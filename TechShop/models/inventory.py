import sys
import os

# Add the parent directory (TechShop) to Python's module search path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from database_connector import DatabaseConnector
from product import Product

class Inventory:
    """Handles inventory management"""

    def __init__(self, product_id):
        self.__product_id = product_id
        self.db = DatabaseConnector()

    def get_product_price(self):
        """Retrieves the price of a product (since stock is not tracked)"""
        query = "SELECT Price FROM Products WHERE ProductID = ?"
        result = self.db.fetch_results(query, (self.__product_id,))
        if result:
            price = result[0][0]
            print(f"💰 Product Price: {price}")
            return price
        print("❌ Product not found.")
        return None

    def list_all_products(self):
        """Lists all products available in the store"""
        query = "SELECT ProductID, ProductName, Description, Price FROM Products"
        result = self.db.fetch_results(query)
        if result:
            print("📋 Product List:", result)
        else:
            print("❌ No products found.")

# Example Usage
if __name__ == "__main__":
    # Test inventory for ProductID 1
    inv1 = Inventory(1)

    # Get product price
    inv1.get_product_price()

    # List all products
    inv1.list_all_products()
