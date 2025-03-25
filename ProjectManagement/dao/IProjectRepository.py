from abc import ABC, abstractmethod

class IProjectRepository(ABC):
    """Interface for Project Management System"""

    @abstractmethod
    def create_employee(self, employee) -> bool:
        pass

    @abstractmethod
    def create_project(self, project) -> bool:
        pass

    @abstractmethod
    def create_task(self, task) -> bool:
        pass
