class Project:
    """Handles Project Management"""

    def __init__(self, project_id, name, description, start_date, status):
        self.__project_id = project_id
        self.__name = name
        self.__description = description
        self.__start_date = start_date
        self.__status = status

    def get_name(self):
        return self.__name

    def get_description(self):
        return self.__description

    def get_start_date(self):
        return self.__start_date

    def get_status(self):
        return self.__status
