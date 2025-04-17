import pytest
from dao.ProjectRepositoryImpl import ProjectRepositoryImpl
from model.employee import Employee
from myexceptions.EmployeeNotFoundException import EmployeeNotFoundException

@pytest.fixture
def repo():
    return ProjectRepositoryImpl()

def test_create_employee(repo):
    """Test adding a new employee"""
    emp = Employee(None, "TestUser", "Software Engineer", "Male", 60000, 1)
    result = repo.create_employee(emp)
    assert result is True

def test_delete_employee_raises_exception(repo):
    """Test deleting a non-existent employee raises exception"""
    emp_id = 9999  # Use a non-existent test employee ID
    with pytest.raises(EmployeeNotFoundException):
        repo.delete_employee(emp_id)
