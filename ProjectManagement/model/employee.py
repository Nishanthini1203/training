class Employee:
    """Handles Employee Management"""

    def __init__(self, emp_id, name, designation, gender, salary, project_id=None):
        self.__emp_id = emp_id
        self.__name = name
        self.__designation = designation
        self.__gender = gender
        self.__salary = salary
        self.__project_id = project_id

    # ✅ Getter methods
    def get_name(self):
        return self.__name

    def get_designation(self):
        return self.__designation

    def get_gender(self):
        return self.__gender

    def get_salary(self):
        return self.__salary

    def get_project_id(self):
        return self.__project_id
