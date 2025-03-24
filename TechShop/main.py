import sys
import os

# Ensure `models/` directory is in the Python path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "models")))

from customer import Customer
from product import Product
from order import Order
from order_details import OrderDetail
from inventory import Inventory

def main_menu():
    """Displays the main menu and handles user input"""
    while True:
        print("\n🛒 Welcome to TechShop CLI 🛒")
        print("1️⃣ Manage Customers")
        print("2️⃣ Manage Products")
        print("3️⃣ Manage Orders")
        print("4️⃣ Manage Inventory")
        print("5️⃣ Exit")
        choice = input("Enter your choice: ")

        if choice == "1":
            customer_menu()
        elif choice == "2":
            product_menu()
        elif choice == "3":
            order_menu()
        elif choice == "4":
            inventory_menu()
        elif choice == "5":
            print("👋 Exiting TechShop CLI. Have a great day!")
            sys.exit()
        else:
            print("❌ Invalid choice! Please enter a valid option.")

def customer_menu():
    """Handles customer-related operations"""
    while True:
        print("\n👤 Customer Management")
        print("1️⃣ Register New Customer")
        print("2️⃣ View Customer Details")
        print("3️⃣ Update Customer Info")
        print("4️⃣ Back to Main Menu")
        choice = input("Enter your choice: ")

        if choice == "1":
            first_name = input("Enter First Name: ")
            last_name = input("Enter Last Name: ")
            email = input("Enter Email: ")
            phone = input("Enter Phone: ")
            address = input("Enter Address: ")
            customer = Customer(None, first_name, last_name, email, phone, address)
            customer.register_customer()
        elif choice == "2":
            customer_id = int(input("Enter Customer ID: "))
            customer = Customer(customer_id, None, None, None, None, None)
            customer.get_customer_details()
        elif choice == "3":
            customer_id = int(input("Enter Customer ID: "))
            new_email = input("Enter New Email: ")
            new_address = input("Enter New Address: ")
            customer = Customer(customer_id, None, None, new_email, None, new_address)
            customer.update_customer_info()
        elif choice == "4":
            return
        else:
            print("❌ Invalid choice! Please enter a valid option.")

def product_menu():
    """Handles product-related operations"""
    while True:
        print("\n📦 Product Management")
        print("1️⃣ Add New Product")
        print("2️⃣ View Product Details")
        print("3️⃣ Back to Main Menu")
        choice = input("Enter your choice: ")

        if choice == "1":
            name = input("Enter Product Name: ")
            description = input("Enter Description: ")
            price = float(input("Enter Price: "))
            product = Product(None, name, description, price)
            product.add_product()
        elif choice == "2":
            product_id = int(input("Enter Product ID: "))
            product = Product(product_id, None, None, None)
            product.get_product_details()
        elif choice == "3":
            return
        else:
            print("❌ Invalid choice! Please enter a valid option.")

def order_menu():
    """Handles order-related operations"""
    while True:
        print("\n📑 Order Management")
        print("1️⃣ Place New Order")
        print("2️⃣ View Order Details")
        print("3️⃣ Update Order Status")
        print("4️⃣ Back to Main Menu")
        choice = input("Enter your choice: ")

        if choice == "1":
            customer_id = int(input("Enter Customer ID: "))
            order_date = input("Enter Order Date (YYYY-MM-DD): ")
            total_amount = float(input("Enter Total Amount: "))
            order = Order(None, customer_id, order_date, total_amount)
            order.add_order()
        elif choice == "2":
            order_id = int(input("Enter Order ID: "))
            order = Order(order_id, None, None, None)
            order.get_order_details()
        elif choice == "3":
            order_id = int(input("Enter Order ID: "))
            new_status = input("Enter New Order Status: ")
            order = Order(order_id, None, None, None)
            order.update_order_status(new_status)
        elif choice == "4":
            return
        else:
            print("❌ Invalid choice! Please enter a valid option.")

def inventory_menu():
    """Handles inventory-related operations"""
    while True:
        print("\n📦 Inventory Management")
        print("1️⃣ View Product Prices")
        print("2️⃣ List All Products")
        print("3️⃣ Back to Main Menu")
        choice = input("Enter your choice: ")

        if choice == "1":
            product_id = int(input("Enter Product ID: "))
            inventory = Inventory(product_id)
            inventory.get_product_price()
        elif choice == "2":
            inventory = Inventory(None)
            inventory.list_all_products()
        elif choice == "3":
            return
        else:
            print("❌ Invalid choice! Please enter a valid option.")

if __name__ == "__main__":
    main_menu()
