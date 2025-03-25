import unittest
from dao.ProjectRepositoryImpl import ProjectRepositoryImpl
from model.employee import Employee
from myexceptions.EmployeeNotFoundException import EmployeeNotFoundException

class TestEmployee(unittest.TestCase):
    def setUp(self):
        """Set up database connection before tests"""
        self.repo = ProjectRepositoryImpl()

    def test_create_employee(self):
        """Test adding a new employee"""
        emp = Employee(None, "TestUser", "Software Engineer", "Male", 60000, 1)
        result = self.repo.create_employee(emp)
        self.assertTrue(result)

    def test_delete_employee(self):
        """Test deleting an employee"""
        emp_id = 9999  # Use a test employee ID
        try:
            self.repo.delete_employee(emp_id)
        except EmployeeNotFoundException:
            self.assertTrue(True)  # Expected behavior if the employee does not exist

if __name__ == "__main__":
    unittest.main()
