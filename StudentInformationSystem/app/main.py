import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from service.sis import SIS
from model.student import Student
from model.teacher import Teacher
from model.course import Course
from datetime import datetime

# Initialize SIS
sis = SIS()

# Create objects
student1 = Student(1, "Nisha", "Verma", "2000-05-10", "nisha@example.com", "9876543210")
teacher1 = Teacher(1, "Anita", "Deshmukh", "anita@college.com", "Data Science")
course1 = Course(101, "Python Programming", "PY101", "TBA")

# Add to SIS
sis.students.append(student1)
sis.teachers.append(teacher1)
sis.courses.append(course1)

# --- TASK 6 Methods Testing ---

# 1. Add Enrollment
sis.add_enrollment(student1, course1, datetime.now())

# 2. Assign Course to Teacher
sis.assign_course_to_teacher(course1, teacher1)

# 3. Add Payment
sis.add_payment(student1, 5000, datetime.now())

# 4. Get Enrollments for Student
print(f"\n📘 Enrollments for {student1.first_name}:")
for enrollment in sis.get_enrollments_for_student(student1):
    print("-", enrollment.course.course_name)

# 5. Get Courses for Teacher
print(f"\n👩‍🏫 Courses taught by {teacher1.first_name}:")
for course in sis.get_courses_for_teacher(teacher1):
    print("-", course.course_name)
