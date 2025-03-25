import unittest
from dao.ProjectRepositoryImpl import ProjectRepositoryImpl
from model.task import Task

class TestTask(unittest.TestCase):
    def setUp(self):
        """Set up database connection before tests"""
        self.repo = ProjectRepositoryImpl()

    def test_create_task(self):
        """Test adding a new task"""
        task = Task(None, "Test Task", 1, 1, "Assigned", "2025-07-01")
        result = self.repo.create_task(task)
        self.assertTrue(result)

    def test_update_task_status(self):
        """Test updating task status and deadline"""
        task_id = 9999  # Use a test task ID
        result = self.repo.update_task(task_id, "Completed", "2025-08-01")
        self.assertFalse(result)  # Expected False if the task does not exist

if __name__ == "__main__":
    unittest.main()
