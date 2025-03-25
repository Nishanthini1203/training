import unittest
from dao.ProjectRepositoryImpl import ProjectRepositoryImpl
from model.project import Project
from myexceptions.ProjectNotFoundException import ProjectNotFoundException

class TestProject(unittest.TestCase):
    def setUp(self):
        """Set up database connection before tests"""
        self.repo = ProjectRepositoryImpl()

    def test_create_project(self):
        """Test adding a new project"""
        proj = Project(None, "Test Project", "Sample Description", "2025-10-01", "Started")
        result = self.repo.create_project(proj)
        self.assertTrue(result)

    def test_update_project_status(self):
        """Test updating project status"""
        project_id = 9999  # Use a test project ID
        try:
            self.repo.update_project(project_id, "Completed")
        except ProjectNotFoundException:
            self.assertTrue(True)  # Expected behavior if the project does not exist

if __name__ == "__main__":
    unittest.main()
