import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

class Teacher:
    def __init__(self, teacher_id, first_name, last_name, email, expertise):
        self.teacher_id = teacher_id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.expertise = expertise
        self.assigned_courses = []

    def update_teacher_info(self, first_name, last_name, email, expertise):
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.expertise = expertise
        print("Teacher information updated.")

    def display_teacher_info(self):
        print(f"Teacher ID: {self.teacher_id}")
        print(f"Name: {self.first_name} {self.last_name}")
        print(f"Email: {self.email}")
        print(f"Expertise: {self.expertise}")

    def get_assigned_courses(self):
        return self.assigned_courses
    
if __name__ == '__main__':
    teacher = Teacher(1, "Anita", "Deshmukh", "anita.deshmukh@edu.com", "Python")

    teacher.display_teacher_info()
    teacher.update_teacher_info("Anita", "Sharma", "anita.sharma@edu.com", "Data Science")
    teacher.display_teacher_info()
