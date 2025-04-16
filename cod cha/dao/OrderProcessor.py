import pyodbc
from exception.CustomExceptions import UserNotFound, OrderNotFound
# In OrderProcessor.py and OrderManagement.py, import Electronics
from entity_model.Electronics import Electronics
from util.DBConnUtil import DBConnUtil

from entity_model.User import User


class OrderProcessor:
    def __init__(self):
        # Assuming DBConnUtil is correctly set up for your SQL Server connection
        self.conn = DBConnUtil.get_db_conn()

    def create_user(self, user):
        cursor = self.conn.cursor()
        try:
            cursor.execute("""
                INSERT INTO Users (username, password, userType)
                VALUES (?, ?, ?)
            """, (user.username, user.password, user.user_type))
            self.conn.commit()
            print(f"User {user.username} created successfully in database.")
        except Exception as e:
            self.conn.rollback()
            print(f"Error while creating user: {e}")

    def create_product(self, admin_username, product):
        cursor = self.conn.cursor()
        try:
            # Insert product into the Product table without product_id since it's auto-generated
            cursor.execute("""
                INSERT INTO Product (productName, description, price, quantityInStock, type)
                VALUES (?, ?, ?, ?, ?)
            """, (product.product_name, product.description, product.price, product.quantity_in_stock, product.type))
            
            # Fetch the product_id for the newly inserted product
            cursor.execute("SELECT SCOPE_IDENTITY()")
            product_id = cursor.fetchone()[0]  # Get the auto-generated product_id

            # Insert into the Electronics table
            if product.type == "Electronics":
                cursor.execute("""
                    INSERT INTO Electronics (productId, brand, warrantyPeriod)
                    VALUES (?, ?, ?)
                """, (product_id, product.brand, product.warranty_period))
            
            self.conn.commit()
            print(f"Product {product.product_name} created successfully in database.")
        except Exception as e:
            self.conn.rollback()
            print(f"Error while creating product: {e}")

    def get_all_products(self):
        cursor = self.conn.cursor()
        try:
            cursor.execute("SELECT * FROM Product")
            return cursor.fetchall()
        except Exception as e:
            print(f"Error while fetching products: {e}")
            return []

    def get_orders_by_user(self, user_id):
        cursor = self.conn.cursor()
        try:
            cursor.execute("""
                SELECT o.orderId, o.orderDate, p.productName, op.quantity 
                FROM Orders o
                JOIN Order_Product op ON o.orderId = op.orderId
                JOIN Product p ON op.productId = p.productId
                WHERE o.userId = ?
            """, (user_id,))
            return cursor.fetchall()
        except Exception as e:
            print(f"Error while fetching orders: {e}")
            return []

    def cancel_order(self, order_id, user_id):
        cursor = self.conn.cursor()
        try:
            cursor.execute("DELETE FROM Order_Product WHERE orderId = ?", (order_id,))
            cursor.execute("DELETE FROM Orders WHERE orderId = ? AND userId = ?", (order_id, user_id))
            self.conn.commit()
            print(f"Order {order_id} cancelled successfully.")
        except Exception as e:
            self.conn.rollback()
            print(f"Error while cancelling order: {e}")
