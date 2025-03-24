import pyodbc

class DatabaseConnector:
    def __init__(self):
        """Initialize database connection"""
        try:
            self.connection = pyodbc.connect(
                "DRIVER={SQL Server};"
                "SERVER=NISHANTHINI\\NISHANTHINI;"
                "DATABASE=TechShop;"
                "Trusted_Connection=yes;"
            )
            print("Connected to TechShop database successfully!")
        except pyodbc.Error as e:
            print(f"Error connecting to database: {e}")

    def execute_query(self, query, params=None):
        """Executes a query with optional parameters"""
        try:
            with self.connection.cursor() as cursor:
                if params:
                    cursor.execute(query, params)
                else:
                    cursor.execute(query)
                self.connection.commit()
        except Exception as e:
            print(f"Error executing query: {e}")

    def fetch_results(self, query, params=None):
        """Fetch results from the database"""
        try:
            with self.connection.cursor() as cursor:
                if params:
                    cursor.execute(query, params)
                else:
                    cursor.execute(query)
                return cursor.fetchall()
        except Exception as e:
            print(f"Error fetching results: {e}")
            return None

    def close_connection(self):
        """Close database connection"""
        if self.connection:
            self.connection.close()
            print("Database connection closed.")

# Example Usage (for testing)
if __name__ == "__main__":
    db = DatabaseConnector()
    db.execute_query("SELECT * FROM Customers")  # Test query
    db.close_connection()
