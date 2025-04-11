import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

class Payment:
    def __init__(self, payment_id, student_id, amount, payment_date):
        self.payment_id = payment_id
        self.student_id = student_id
        self.amount = amount
        self.payment_date = payment_date
        self.student = None  # optional object reference

    def get_student(self):
        return self.student

    def get_payment_amount(self):
        return self.amount

    def get_payment_date(self):
        return self.payment_date

if __name__ == '__main__':
    from model.student import Student
    from datetime import datetime

    student = Student(1, "Nisha", "Verma", "2000-05-10", "nisha@example.com", "9876543210")
    payment = Payment(1, student.student_id, 5000, datetime.now())
    payment.student = student

    print("Payment Details:")
    print("Student:", payment.get_student().first_name, payment.get_student().last_name)
    print("Amount Paid: ₹", payment.get_payment_amount())
    print("Date:", payment.get_payment_date().strftime("%Y-%m-%d"))
