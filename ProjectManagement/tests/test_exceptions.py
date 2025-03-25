import unittest
from dao.ProjectRepositoryImpl import ProjectRepositoryImpl
from myexceptions.EmployeeNotFoundException import EmployeeNotFoundException
from myexceptions.ProjectNotFoundException import ProjectNotFoundException

class TestExceptions(unittest.TestCase):
    def setUp(self):
        """Set up database connection before tests"""
        self.repo = ProjectRepositoryImpl()

    def test_employee_not_found_exception(self):
        """Test EmployeeNotFoundException when deleting a non-existing employee"""
        with self.assertRaises(EmployeeNotFoundException):
            self.repo.delete_employee(9999)  # Non-existing employee ID

    def test_project_not_found_exception(self):
        """Test ProjectNotFoundException when updating a non-existing project"""
        with self.assertRaises(ProjectNotFoundException):
            self.repo.update_project(9999, "In Progress")  # Non-existing project ID

if __name__ == "__main__":
    unittest.main()
