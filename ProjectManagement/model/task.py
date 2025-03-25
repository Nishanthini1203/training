class Task:
    """Handles Task Management"""

    def __init__(self, task_id, name, project_id, employee_id, status, deadline_date=None):
        self.__task_id = task_id
        self.__name = name
        self.__project_id = project_id
        self.__employee_id = employee_id
        self.__status = status
        self.__deadline_date = deadline_date

    # ✅ Getter methods
    def get_name(self):
        return self.__name

    def get_project_id(self):
        return self.__project_id

    def get_employee_id(self):
        return self.__employee_id

    def get_status(self):
        return self.__status

    def get_deadline_date(self):
        return self.__deadline_date
