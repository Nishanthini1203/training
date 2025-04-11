import sys
import os
import pyodbc
from datetime import datetime

# Add parent directory to sys.path for db_connector
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from db_connector import get_connection


class QueryBuilder:
    def __init__(self):
        self.conn = get_connection()
        self.cursor = self.conn.cursor()

    def add_student(self):
        print("\n📘 Enter student details:")
        first = input("First Name: ")
        last = input("Last Name: ")
        dob = input("Date of Birth (YYYY-MM-DD): ")
        email = input("Email: ")
        phone = input("Phone Number: ")

        self.cursor.execute("SELECT student_id FROM Students WHERE email = ?", (email,))
        existing = self.cursor.fetchone()
        if existing:
            sid = existing[0]
            self.cursor.execute("DELETE FROM Payments WHERE student_id = ?", (sid,))
            self.cursor.execute("DELETE FROM Enrollments WHERE student_id = ?", (sid,))
            self.cursor.execute("DELETE FROM Students WHERE student_id = ?", (sid,))
            print("⚠️ Existing student deleted before re-adding.")

        self.cursor.execute('''
            INSERT INTO Students (first_name, last_name, date_of_birth, email, phone_number)
            VALUES (?, ?, ?, ?, ?)
        ''', (first, last, dob, email, phone))
        self.conn.commit()
        print(f"✅ Student {first} {last} added.")

    def get_student_id(self, email):
        self.cursor.execute("SELECT student_id FROM Students WHERE email = ?", (email,))
        row = self.cursor.fetchone()
        return row[0] if row else None

    def enroll_student(self):
        email = input("\nEnter student email to enroll: ")
        student_id = self.get_student_id(email)
        if not student_id:
            print("❌ Student not found.")
            return

        courses = input("Enter course names to enroll (comma-separated): ").split(',')
        self.cursor.execute("DELETE FROM Enrollments WHERE student_id = ?", (student_id,))
        print("⚠️ Existing enrollments deleted.")

        for cname in courses:
            cname = cname.strip()
            self.cursor.execute("SELECT course_id FROM Courses WHERE course_name = ?", (cname,))
            result = self.cursor.fetchone()
            if result:
                course_id = result[0]
                self.cursor.execute('''
                    INSERT INTO Enrollments (student_id, course_id, enrollment_date)
                    VALUES (?, ?, GETDATE())
                ''', (student_id, course_id))
                print(f"✅ Enrolled in: {cname}")
            else:
                print(f"⚠️ Course '{cname}' not found.")
        self.conn.commit()

    def add_teacher_and_assign(self):
        print("\n👩‍🏫 Enter teacher details:")
        name = input("Full Name: ")
        email = input("Email: ")
        expertise = input("Expertise: ")
        code = input("Course Code to assign: ")

        self.cursor.execute("SELECT teacher_id FROM Teachers WHERE email = ?", (email,))
        teacher = self.cursor.fetchone()
        if teacher:
            tid = teacher[0]
            self.cursor.execute("UPDATE Courses SET teacher_id = NULL WHERE teacher_id = ?", (tid,))
            self.cursor.execute("DELETE FROM Teachers WHERE teacher_id = ?", (tid,))
            print("⚠️ Existing teacher deleted before re-adding.")

        first, last = name.split()[0], name.split()[1]
        self.cursor.execute(
            "INSERT INTO Teachers (first_name, last_name, email) VALUES (?, ?, ?)",
            (first, last, email)
        )
        self.conn.commit()

        self.cursor.execute("SELECT teacher_id FROM Teachers WHERE email = ?", (email,))
        new_tid = self.cursor.fetchone()[0]
        self.cursor.execute(
            "UPDATE Courses SET teacher_id = ? WHERE course_code = ?",
            (new_tid, code)
        )
        self.conn.commit()
        print(f"✅ Teacher {name} assigned to course {code}")

    def record_payment(self):
        print("\n💰 Record Payment")
        student_id = input("Enter Student ID: ")
        amount_input = input("Enter amount (e.g., 500.00): ").replace('$', '').strip()
        amount = float(amount_input)
        date = input("Enter payment date (YYYY-MM-DD): ")

        self.cursor.execute("SELECT * FROM Students WHERE student_id = ?", (student_id,))
        if not self.cursor.fetchone():
            print("❌ No such student exists. Please add the student first.")
            return

        self.cursor.execute("SELECT payment_id FROM Payments WHERE student_id = ? AND payment_date = ?", (student_id, date))
        if self.cursor.fetchone():
            self.cursor.execute("DELETE FROM Payments WHERE student_id = ? AND payment_date = ?", (student_id, date))
            print("⚠️ Existing payment on same date deleted.")

        self.cursor.execute(
            "INSERT INTO Payments (student_id, amount, payment_date) VALUES (?, ?, ?)",
            (student_id, amount, date)
        )
        self.conn.commit()
        print("✅ Payment recorded.")

    def generate_enrollment_report(self):
        course = input("\nEnter course name for report: ")
        self.cursor.execute('''
            SELECT s.first_name, s.last_name, e.enrollment_date
            FROM Enrollments e
            JOIN Students s ON s.student_id = e.student_id
            JOIN Courses c ON c.course_id = e.course_id
            WHERE c.course_name = ?
        ''', (course,))
        rows = self.cursor.fetchall()
        if rows:
            print(f"\n📋 Enrollment Report for '{course}':")
            for row in rows:
                print(f"- {row.first_name} {row.last_name} on {row.enrollment_date}")

            # Save to .txt file
            filename = f"enrollment_report_{course.replace(' ', '_')}.txt"
            with open(filename, "w") as f:
                f.write(f"Enrollment Report for '{course}':\n")
                for row in rows:
                    f.write(f"- {row.first_name} {row.last_name} on {row.enrollment_date}\n")
            print(f"\n💾 Report saved to {filename}")
        else:
            print("⚠️ No enrollments found for this course.")

    def close(self):
        if self.conn:
            self.conn.close()
            print("🔒 Connection closed.")


def show_menu():
    print("\n🎓 STUDENT INFORMATION SYSTEM - DATABASE MENU")
    print("1. Add New Student")
    print("2. Enroll Student in Courses")
    print("3. Assign Teacher to Course")
    print("4. Record Student Payment")
    print("5. Generate Enrollment Report")
    print("0. Exit")


if __name__ == "__main__":
    qb = QueryBuilder()
    while True:
        show_menu()
        choice = input("Choose an option (0-5): ").strip()
        if choice == "1":
            qb.add_student()
        elif choice == "2":
            qb.enroll_student()
        elif choice == "3":
            qb.add_teacher_and_assign()
        elif choice == "4":
            qb.record_payment()
        elif choice == "5":
            qb.generate_enrollment_report()
        elif choice == "0":
            qb.close()
            break
        else:
            print("❌ Invalid choice. Try again.")
