import pytest
from dao.ProjectRepositoryImpl import ProjectRepositoryImpl
from model.task import Task

@pytest.fixture
def repo():
    return ProjectRepositoryImpl()

def test_create_task(repo):
    """Test adding a new task"""
    task = Task(None, "Test Task", 1, 1, "Assigned", "2025-07-01")
    result = repo.create_task(task)
    assert result is True

def test_update_task_status_returns_false_for_invalid_task(repo):
    """Test updating task status returns False if task does not exist"""
    task_id = 9999  # Non-existing test task ID
    result = repo.update_task(task_id, "Completed", "2025-08-01")
    assert result is False  # Ensure method returns False for invalid task
