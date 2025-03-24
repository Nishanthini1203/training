import sys
import os

# Add the parent directory (TechShop) to Python's module search path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from product import Product
from order import Order
from database_connector import DatabaseConnector

class OrderDetail:
    """Handles order details, linking products to orders"""

    def __init__(self, order_detail_id, order_id, product_id, quantity):
        self.__order_detail_id = order_detail_id
        self.__order_id = order_id
        self.__product_id = product_id
        self.__quantity = quantity
        self.db = DatabaseConnector()

    def add_order_detail(self):
        """Inserts a new order detail into the database and retrieves its ID"""
        query = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES (?, ?, ?)"
        self.db.execute_query(query, (self.__order_id, self.__product_id, self.__quantity))
        print(f"✅ Order detail added: Order {self.__order_id}, Product {self.__product_id}")

        # Retrieve and store the last inserted OrderDetailID
        query = "SELECT TOP 1 OrderDetailID FROM OrderDetails ORDER BY OrderDetailID DESC"
        result = self.db.fetch_results(query)
        if result:
            self.__order_detail_id = result[0][0]  # Store last inserted OrderDetailID

    def update_quantity(self, new_quantity):
        """Updates the quantity of the product in the order detail"""
        if self.__order_detail_id is None:
            print("❌ No OrderDetailID set. Add an order detail first.")
            return
        
        query = "UPDATE OrderDetails SET Quantity = ? WHERE OrderDetailID = ?"
        self.db.execute_query(query, (new_quantity, self.__order_detail_id))
        self.__quantity = new_quantity
        print(f"✅ Quantity updated for OrderDetail {self.__order_detail_id}: New Quantity {new_quantity}")

    def get_order_detail_info(self):
        """Fetch and display order detail information"""
        if self.__order_detail_id is None:
            print("❌ No OrderDetailID set. Add an order detail first.")
            return
        
        query = """
        SELECT OD.OrderDetailID, O.OrderID, P.ProductName, OD.Quantity
        FROM OrderDetails OD
        JOIN Orders O ON OD.OrderID = O.OrderID
        JOIN Products P ON OD.ProductID = P.ProductID
        WHERE OD.OrderDetailID = ?
        """
        result = self.db.fetch_results(query, (self.__order_detail_id,))
        
        if result:
            print("📋 Order Detail Info:", result)
        else:
            print("❌ Order Detail not found.")

# Example Usage
if __name__ == "__main__":
    # Test order detail creation
    od1 = OrderDetail(None, 12, 1, 2)  # OrderID 12, ProductID 1, Quantity 2
    od1.add_order_detail()

    # Fetch and display order detail information
    od1.get_order_detail_info()

    # Update quantity
    od1.update_quantity(3)
