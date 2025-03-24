import sys
import os
import re

# Add the parent directory (TechShop) to Python's module search path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from database_connector import DatabaseConnector

class Customer:
    """Handles customer information and operations"""

    def __init__(self, customer_id, first_name, last_name, email, phone, address):
        self.__customer_id = customer_id
        self.__first_name = first_name
        self.__last_name = last_name
        self.__email = None  # Initialize email as None to avoid validation error
        self.__phone = phone
        self.__address = address
        self.db = DatabaseConnector()

        if email is not None:  # Only validate if email is provided
            self.set_email(email)

    # Setter with validation
    def set_email(self, email):
        """Validates and sets the customer's email"""
        if email is not None and not re.match(r"[^@]+@[^@]+\.[^@]+", email):
            raise ValueError("❌ Invalid email format!")
        self.__email = email

    def register_customer(self):
        """Registers a new customer"""
        # Check if customer already exists
        check_query = "SELECT CustomerID FROM Customers WHERE Phone = ?"
        result = self.db.fetch_results(check_query, (self.__phone,))
        if result:
            print(f"❌ Customer with phone {self.__phone} already exists! Registration failed.")
            return

        # Insert new customer
        query = "INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES (?, ?, ?, ?, ?)"
        self.db.execute_query(query, (self.__first_name, self.__last_name, self.__email, self.__phone, self.__address))
        print("✅ Customer registered successfully!")

    def get_customer_details(self):
        """Fetches and displays customer details"""
        query = "SELECT * FROM Customers WHERE CustomerID = ?"
        result = self.db.fetch_results(query, (self.__customer_id,))
        if result:
            print("📋 Customer Details:", result)
        else:
            print("❌ Customer not found.")

    def update_customer_info(self):
        """Updates customer email and address"""
        query = "UPDATE Customers SET Email = ?, Address = ? WHERE CustomerID = ?"
        self.db.execute_query(query, (self.__email, self.__address, self.__customer_id))
        print("✅ Customer info updated successfully!")

# Example Usage
if __name__ == "__main__":
    # Test: View an existing customer
    customer_id = 1  # Change to a valid CustomerID
    c1 = Customer(customer_id, None, None, None, None, None)
    c1.get_customer_details()
