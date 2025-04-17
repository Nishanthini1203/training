import pytest
from dao.ProjectRepositoryImpl import ProjectRepositoryImpl
from model.project import Project
from myexceptions.ProjectNotFoundException import ProjectNotFoundException

@pytest.fixture
def repo():
    return ProjectRepositoryImpl()

def test_create_project(repo):
    """Test adding a new project"""
    proj = Project(None, "Test Project", "Sample Description", "2025-10-01", "Started")
    result = repo.create_project(proj)
    assert result is True

def test_update_project_status_raises_exception(repo):
    """Test updating a non-existing project raises ProjectNotFoundException"""
    with pytest.raises(ProjectNotFoundException):
        repo.update_project(9999, "Completed")  # Non-existent project ID
