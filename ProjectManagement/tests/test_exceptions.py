import pytest
from dao.ProjectRepositoryImpl import ProjectRepositoryImpl
from myexceptions.EmployeeNotFoundException import EmployeeNotFoundException
from myexceptions.ProjectNotFoundException import ProjectNotFoundException

@pytest.fixture
def repo():
    return ProjectRepositoryImpl()

def test_employee_not_found_exception(repo):
    """Test EmployeeNotFoundException when deleting a non-existing employee"""
    with pytest.raises(EmployeeNotFoundException):
        repo.delete_employee(9999)  # Non-existing employee ID

def test_project_not_found_exception(repo):
    """Test ProjectNotFoundException when updating a non-existing project"""
    with pytest.raises(ProjectNotFoundException):
        repo.update_project(9999, "In Progress")  # Non-existing project ID
