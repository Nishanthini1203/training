import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from model.enrollment import Enrollment
from model.payment import Payment

class Student:
    def __init__(self, student_id, first_name, last_name, date_of_birth, email, phone_number):
        self.student_id = student_id
        self.first_name = first_name
        self.last_name = last_name
        self.date_of_birth = date_of_birth
        self.email = email
        self.phone_number = phone_number
        self.enrollments = []
        self.payments = []
    def enroll_in_course(self, course):
        enrollment = Enrollment(None, self.student_id, course.course_id, "2025-04-11")
        self.enrollments.append(enrollment)
        print(f"{self.first_name} enrolled in {course.course_name}")
    def update_student_info(self, first_name, last_name, date_of_birth, email, phone_number):
        self.first_name = first_name
        self.last_name = last_name
        self.date_of_birth = date_of_birth
        self.email = email
        self.phone_number = phone_number
        print("Student information updated.")
    def make_payment(self, amount, payment_date):
        payment = Payment(None, self.student_id, amount, payment_date)
        self.payments.append(payment)
        print(f"Payment of ₹{amount} made on {payment_date}")
    def display_student_info(self):
        print(f"Student ID: {self.student_id}")
        print(f"Name: {self.first_name} {self.last_name}")
        print(f"DOB: {self.date_of_birth}")
        print(f"Email: {self.email}")
        print(f"Phone: {self.phone_number}")
    def get_enrolled_courses(self):
        return self.enrollments
    def get_payment_history(self):
        return self.payments


