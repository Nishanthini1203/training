import sys
import os

# Add the parent directory (TechShop) to Python's module search path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from database_connector import DatabaseConnector
from models.customer import Customer  # Import Customer for composition

class Order:
    """Handles order details"""

    def __init__(self, order_id, customer_id, order_date, total_amount, status="Pending"):
        self.__order_id = order_id
        self.__customer_id = customer_id
        self.__order_date = order_date
        self.__total_amount = total_amount
        self.__status = status
        self.db = DatabaseConnector()

    def add_order(self):
        """Inserts a new order into the database"""
        query = "INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status) VALUES (?, ?, ?, ?)"
        self.db.execute_query(query, (self.__customer_id, self.__order_date, self.__total_amount, self.__status))
        print(f"✅ Order placed successfully for CustomerID {self.__customer_id}!")

        # Retrieve and store the last inserted OrderID
        query = "SELECT TOP 1 OrderID FROM Orders ORDER BY OrderID DESC"
        result = self.db.fetch_results(query)
        if result:
            self.__order_id = result[0][0]  # Store last inserted OrderID

    def update_order_status(self, new_status):
        """Updates order status (e.g., Pending → Shipped)"""
        query = "UPDATE Orders SET Status = ? WHERE OrderID = ?"
        self.db.execute_query(query, (new_status, self.__order_id))
        self.__status = new_status
        print(f"✅ Order {self.__order_id} updated to status: {new_status}")

    def get_order_details(self):
        """Fetch and display order details"""
        query = """
        SELECT O.OrderID, O.OrderDate, O.TotalAmount, O.Status, C.FirstName, C.LastName
        FROM Orders O
        JOIN Customers C ON O.CustomerID = C.CustomerID
        WHERE O.OrderID = ?
        """
        result = self.db.fetch_results(query, (self.__order_id,))
        
        if result:
            print("📋 Order Details:", result)
        else:
            print("❌ Order not found.")

    def cancel_order(self):
        """Cancels an order and removes it from the database"""
        query = "DELETE FROM Orders WHERE OrderID = ?"
        self.db.execute_query(query, (self.__order_id,))
        print(f"✅ Order {self.__order_id} has been canceled.")

# Example Usage
if __name__ == "__main__":
    # Test order creation
    o1 = Order(None, 1, "2024-03-25", 1500.00)  # CustomerID 1 places an order
    o1.add_order()

    # Fetch and display order details
    o1.get_order_details()

    # Update order status
    o1.update_order_status("Shipped")

    # Cancel order (if needed)
    # o1.cancel_order()
