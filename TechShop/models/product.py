import sys
import os

# Add the parent directory (TechShop) to Python's module search path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from database_connector import DatabaseConnector

class Product:
    """Handles product management"""

    def __init__(self, product_id, name, description, price):
        self.__product_id = product_id
        self.__name = name
        self.__description = description
        self.__price = None  # Initialize price as None to avoid validation error
        self.db = DatabaseConnector()

        if price is not None:  # Only validate if price is provided
            self.set_price(price)

    # Setter with validation
    def set_price(self, price):
        """Validates and sets the product's price"""
        if price is not None and price <= 0:
            raise ValueError("❌ Price must be greater than zero!")
        self.__price = price

    def add_product(self):
        """Adds a new product to the database"""
        query = "INSERT INTO Products (ProductName, Description, Price) VALUES (?, ?, ?)"
        self.db.execute_query(query, (self.__name, self.__description, self.__price))
        print(f"✅ Product '{self.__name}' added successfully!")

    def get_product_details(self):
        """Fetches and displays product details"""
        query = "SELECT * FROM Products WHERE ProductID = ?"
        result = self.db.fetch_results(query, (self.__product_id,))
        if result:
            print("📋 Product Details:", result)
        else:
            print("❌ Product not found.")

# Example Usage
if __name__ == "__main__":
    # Test: View an existing product
    product_id = 1  # Change to a valid ProductID
    p1 = Product(product_id, None, None, None)
    p1.get_product_details()
