import sys
import os

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from dao.IProjectRepository import IProjectRepository
from util.dbconnector import DatabaseConnector
from model.employee import Employee
from model.project import Project
from model.task import Task
from myexceptions.EmployeeNotFoundException import EmployeeNotFoundException
from myexceptions.ProjectNotFoundException import ProjectNotFoundException

class ProjectRepositoryImpl(IProjectRepository):
    """Implementation of IProjectRepository using MSSQL"""

    def __init__(self):
        self.db = DatabaseConnector()

    # ✅ Create Operations (Add Employee, Project, Task)
    def create_employee(self, employee: Employee) -> bool:
        """Insert new employee into the database"""
        query = "INSERT INTO Employee (name, designation, gender, salary, project_id) VALUES (?, ?, ?, ?, ?)"
        self.db.execute_query(query, (employee.get_name(), employee.get_designation(), employee.get_gender(), employee.get_salary(), employee.get_project_id()))
        print(f"✅ Employee '{employee.get_name()}' added successfully!")
        return True

    def create_project(self, project: Project) -> bool:
        """Insert new project into the database"""
        query = "INSERT INTO Project (projectName, description, startDate, status) VALUES (?, ?, ?, ?)"
        self.db.execute_query(query, (project.get_name(), project.get_description(), project.get_start_date(), project.get_status()))
        print(f"✅ Project '{project.get_name()}' added successfully!")
        return True

    def create_task(self, task: Task) -> bool:
        """Insert new task into the database"""
        query = "INSERT INTO Task (task_name, project_id, employee_id, status, deadline_date) VALUES (?, ?, ?, ?, ?)"
        self.db.execute_query(query, (task.get_name(), task.get_project_id(), task.get_employee_id(), task.get_status(), task.get_deadline_date()))
        print(f"✅ Task '{task.get_name()}' added successfully!")
        return True

    # ✅ Read Operations (View Employees, Projects, Tasks)
    def get_all_employees(self):
        """Retrieve all employees"""
        query = "SELECT * FROM Employee"
        employees = self.db.fetch_results(query)

        if not employees:
            print("❌ No employees found.")
        else:
            print("\n📋 Employee List:")
            for emp in employees:
                print(f"ID: {emp[0]}, Name: {emp[1]}, Role: {emp[2]}, Gender: {emp[3]}, Salary: {emp[4]}, Project ID: {emp[5]}")

        return employees

    def get_all_projects(self):
        """Retrieve all projects"""
        query = "SELECT * FROM Project"
        projects = self.db.fetch_results(query)

        if not projects:
            print("❌ No projects found.")
        else:
            print("\n📋 Project List:")
            for proj in projects:
                print(f"ID: {proj[0]}, Name: {proj[1]}, Description: {proj[2]}, Start Date: {proj[3]}, Status: {proj[4]}")

        return projects

    def get_all_tasks(self):
        """Retrieve all tasks"""
        query = "SELECT * FROM Task"
        tasks = self.db.fetch_results(query)

        if not tasks:
            print("❌ No tasks found.")
        else:
            print("\n📋 Task List:")
            for task in tasks:
                print(f"ID: {task[0]}, Name: {task[1]}, Project ID: {task[2]}, Employee ID: {task[3]}, Status: {task[4]}, Deadline: {task[5]}")

        return tasks

    # ✅ Update Operations (Update Employee Salary, Project Status, Task)
    def update_employee(self, emp_id: int, new_salary: float):
        """Update an employee's salary"""
        query = "UPDATE Employee SET salary = ? WHERE id = ?"
        self.db.execute_query(query, (new_salary, emp_id))
        print(f"✅ Employee ID {emp_id} salary updated successfully!")

    def update_project(self, project_id: int, new_status: str):
        """Update project status with exception handling"""
        # Check if Project ID exists before updating
        query_check = "SELECT id FROM Project WHERE id = ?"
        result = self.db.fetch_results(query_check, (project_id,))
        if not result:
            raise ProjectNotFoundException(f"❌ Error: Project ID {project_id} does not exist!")

        # Update Project Status
        query = "UPDATE Project SET status = ? WHERE id = ?"
        self.db.execute_query(query, (new_status, project_id))
        print(f"✅ Project ID {project_id} updated successfully!")
        return True

    def update_task(self, task_id: int, new_status: str, new_deadline: str):
        """Update task status and deadline"""
        query = "UPDATE Task SET status = ?, deadline_date = ? WHERE task_id = ?"
        self.db.execute_query(query, (new_status, new_deadline, task_id))
        print(f"✅ Task ID {task_id} updated successfully!")

    # ✅ Delete Operations (Remove Employee, Project, Task)
    def delete_employee(self, emp_id: int):
        """Delete an employee with exception handling"""
        # Check if Employee ID exists before deleting
        query_check = "SELECT id FROM Employee WHERE id = ?"
        result = self.db.fetch_results(query_check, (emp_id,))
        if not result:
            raise EmployeeNotFoundException(f"❌ Error: Employee ID {emp_id} does not exist!")

        # Delete Employee
        query = "DELETE FROM Employee WHERE id = ?"
        self.db.execute_query(query, (emp_id,))
        print(f"✅ Employee ID {emp_id} deleted.")
        return True

    def delete_project(self, project_id: int):
        """Delete a project"""
        self.db.execute_query("DELETE FROM Employee WHERE project_id = ?", (project_id,))
        self.db.execute_query("DELETE FROM Task WHERE project_id = ?", (project_id,))
        self.db.execute_query("DELETE FROM Project WHERE id = ?", (project_id,))
        print(f"✅ Project ID {project_id} deleted.")

    def delete_task(self, task_id: int):
        """Delete a task"""
        query = "DELETE FROM Task WHERE task_id = ?"
        self.db.execute_query(query, (task_id,))
        print(f"✅ Task ID {task_id} deleted.")

    # ✅ Expense Report
    def generate_expense_report(self):
        """Generate salary expense report by project"""
        query = """
        SELECT p.projectName, COALESCE(SUM(DISTINCT e.salary), 0) AS total_expense
        FROM Project p
        LEFT JOIN Employee e ON p.id = e.project_id
        GROUP BY p.projectName
        ORDER BY total_expense DESC;
        """
        results = self.db.fetch_results(query)

        if not results:
            print("❌ No expense data available.")
            return

        print("\n📊 Salary Expense Report:")
        for row in results:
            print(f"Project: {row[0]} | Total Expense: {row[1]:,.2f}")
