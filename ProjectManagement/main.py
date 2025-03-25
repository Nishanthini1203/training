from model.employee import Employee
from model.project import Project
from model.task import Task
from dao.ProjectRepositoryImpl import ProjectRepositoryImpl
from myexceptions.EmployeeNotFoundException import EmployeeNotFoundException
from myexceptions.ProjectNotFoundException import ProjectNotFoundException

repo = ProjectRepositoryImpl()

def main():
    while True:
        print("\n1. Add Employee\n2. Add Project\n3. Add Task\n4. View Employees\n5. View Projects\n6. View Tasks\n7. Update Employee Salary\n8. Update Project Status\n9. Update Task\n10. Delete Employee\n11. Delete Project\n12. Delete Task\n13. Expense Report\n14. Exit")
        choice = input("Enter your choice: ")

        try:
            if choice == "1":
                name = input("Enter Name: ")
                designation = input("Enter Designation: ")
                gender = input("Enter Gender: ")
                salary = float(input("Enter Salary: "))
                project_id = input("Enter Project ID (or leave blank): ")
                project_id = int(project_id) if project_id else None
                emp = Employee(None, name, designation, gender, salary, project_id)
                repo.create_employee(emp)

            elif choice == "2":
                name = input("Enter Project Name: ")
                description = input("Enter Description: ")
                start_date = input("Enter Start Date (YYYY-MM-DD): ")
                status = input("Enter Status: ")
                project = Project(None, name, description, start_date, status)
                repo.create_project(project)

            elif choice == "3":
                name = input("Enter Task Name: ")
                project_id = int(input("Enter Project ID: "))
                employee_id = int(input("Enter Employee ID: "))
                status = input("Enter Status: ")
                deadline_date = input("Enter Deadline (YYYY-MM-DD): ")
                task = Task(None, name, project_id, employee_id, status, deadline_date)
                repo.create_task(task)

            elif choice == "4":
                employees = repo.get_all_employees()
                print(employees)

            elif choice == "5":
                projects = repo.get_all_projects()
                print(projects)

            elif choice == "6":
                tasks = repo.get_all_tasks()
                print(tasks)

            elif choice == "7":
                emp_id = int(input("Enter Employee ID: "))
                new_salary = float(input("Enter New Salary: "))
                repo.update_employee(emp_id, new_salary)

            elif choice == "8":
                project_id = int(input("Enter Project ID: "))
                new_status = input("Enter New Status: ")
                repo.update_project(project_id, new_status)

            elif choice == "9":
                task_id = int(input("Enter Task ID: "))
                new_status = input("Enter New Status: ")
                new_deadline = input("Enter New Deadline (YYYY-MM-DD): ")
                repo.update_task(task_id, new_status, new_deadline)

            elif choice == "10":
                emp_id = int(input("Enter Employee ID to Delete: "))
                repo.delete_employee(emp_id)

            elif choice == "11":
                project_id = int(input("Enter Project ID to Delete: "))
                repo.delete_project(project_id)

            elif choice == "12":
                task_id = int(input("Enter Task ID to Delete: "))
                repo.delete_task(task_id)

            elif choice == "13":
                repo.generate_expense_report()

            elif choice == "14":
                print("Exiting...")
                break

        except Exception as e:
            print(f"❌ Error: {e}")

if __name__ == "__main__":
    main()
