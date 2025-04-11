import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from model.student import Student
from model.teacher import Teacher
from model.course import Course
from model.enrollment import Enrollment
from model.payment import Payment
from datetime import datetime

# Task 4 - Custom Exceptions
from myexceptions.student_not_found_exception import StudentNotFoundException
from myexceptions.course_not_found_exception import CourseNotFoundException
from myexceptions.duplicate_enrollment_exception import DuplicateEnrollmentException
from myexceptions.teacher_not_found_exception import TeacherNotFoundException
from myexceptions.payment_validation_exception import PaymentValidationException

class SIS:
    def __init__(self):
        self.students = []
        self.teachers = []
        self.courses = []
        self.enrollments = []
        self.payments = []
        print("✅ Student Information System initialized.")

    # Task 3 + 4: Enroll student in course
    def enroll_student_in_course(self, student, course):
        if student not in self.students:
            raise StudentNotFoundException()
        if course not in self.courses:
            raise CourseNotFoundException()
        for enrollment in self.enrollments:
            if enrollment.student_id == student.student_id and enrollment.course_id == course.course_id:
                raise DuplicateEnrollmentException()

        enrollment = Enrollment(len(self.enrollments)+1, student.student_id, course.course_id, datetime.now())
        enrollment.student = student
        enrollment.course = course
        self.enrollments.append(enrollment)
        student.enrollments.append(enrollment)
        course.enrollments.append(enrollment)
        print(f"✅ {student.first_name} enrolled in {course.course_name}.")

    # Task 3 + 4: Assign teacher to course
    def assign_teacher_to_course(self, teacher, course):
        if teacher not in self.teachers:
            raise TeacherNotFoundException()
        if course not in self.courses:
            raise CourseNotFoundException()

        course.assign_teacher(teacher)
        teacher.assigned_courses.append(course)
        print(f"✅ Teacher {teacher.first_name} assigned to {course.course_name}.")

    # Task 3 + 4: Record payment
    def record_payment(self, student, amount, payment_date):
        if student not in self.students:
            raise StudentNotFoundException()
        if amount <= 0:
            raise PaymentValidationException()

        payment = Payment(len(self.payments)+1, student.student_id, amount, payment_date)
        payment.student = student
        self.payments.append(payment)
        student.payments.append(payment)
        print(f"✅ Payment of ₹{amount} recorded for {student.first_name} on {payment_date.strftime('%Y-%m-%d')}.")

    # Task 3: Reports
    def generate_enrollment_report(self, course):
        print(f"📋 Enrollment Report for Course: {course.course_name}")
        for enrollment in course.enrollments:
            student = enrollment.get_student()
            print(f"- {student.first_name} {student.last_name} | Enrolled on: {enrollment.enrollment_date.strftime('%Y-%m-%d')}")

    def generate_payment_report(self, student):
        print(f"📋 Payment Report for Student: {student.first_name} {student.last_name}")
        for payment in student.payments:
            print(f"- ₹{payment.amount} on {payment.payment_date.strftime('%Y-%m-%d')}")

    def calculate_course_statistics(self, course):
        total_enrollments = len(course.enrollments)
        total_payments = sum(
            payment.amount
            for enrollment in course.enrollments
            for payment in enrollment.student.payments
        )
        print(f"📊 Statistics for {course.course_name}:")
        print(f"- Total Enrollments: {total_enrollments}")
        print(f"- Total Payments Received: ₹{total_payments}")

    # Task 6: Relationship management methods
    def add_enrollment(self, student, course, enrollment_date):
        if student not in self.students:
            raise StudentNotFoundException()
        if course not in self.courses:
            raise CourseNotFoundException()

        enrollment = Enrollment(len(self.enrollments)+1, student.student_id, course.course_id, enrollment_date)
        enrollment.student = student
        enrollment.course = course
        self.enrollments.append(enrollment)
        student.enrollments.append(enrollment)
        course.enrollments.append(enrollment)
        print(f"✅ Enrollment added for {student.first_name} in {course.course_name}")

    def assign_course_to_teacher(self, course, teacher):
        if teacher not in self.teachers:
            raise TeacherNotFoundException()
        if course not in self.courses:
            raise CourseNotFoundException()

        course.assign_teacher(teacher)
        teacher.assigned_courses.append(course)
        print(f"✅ {course.course_name} assigned to {teacher.first_name}")

    def add_payment(self, student, amount, payment_date):
        if student not in self.students:
            raise StudentNotFoundException()
        if amount <= 0:
            raise PaymentValidationException()

        payment = Payment(len(self.payments)+1, student.student_id, amount, payment_date)
        payment.student = student
        self.payments.append(payment)
        student.payments.append(payment)
        print(f"💰 Payment of ₹{amount} added for {student.first_name}")

    def get_enrollments_for_student(self, student):
        if student not in self.students:
            raise StudentNotFoundException()
        return student.enrollments

    def get_courses_for_teacher(self, teacher):
        if teacher not in self.teachers:
            raise TeacherNotFoundException()
        return teacher.assigned_courses
