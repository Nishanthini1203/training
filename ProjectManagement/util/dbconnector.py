import pyodbc

class DatabaseConnector:
    """Handles database connection for MSSQL"""

    def __init__(self):
        try:
            self.connection = pyodbc.connect(
                "DRIVER={SQL Server};"
                "SERVER=NISHANTHINI\\NISHANTHINI;"  # Update your SQL Server name
                "DATABASE=ProjectManagement;"
                "Trusted_Connection=yes;"
            )
            print("✅ Connected to ProjectManagement database successfully!")
        except pyodbc.Error as e:
            print(f"❌ Error connecting to database: {e}")

    def execute_query(self, query, params=None):
        """Executes a query (INSERT, UPDATE, DELETE)"""
        try:
            with self.connection.cursor() as cursor:
                cursor.execute(query, params) if params else cursor.execute(query)
                self.connection.commit()
        except Exception as e:
            print(f"❌ Error executing query: {e}")

    def fetch_results(self, query, params=None):
        """Fetches results from a SELECT query"""
        try:
            with self.connection.cursor() as cursor:
                cursor.execute(query, params) if params else cursor.execute(query)
                return cursor.fetchall()
        except Exception as e:
            print(f"❌ Error fetching results: {e}")
            return None

    def close_connection(self):
        """Close the database connection"""
        if self.connection:
            self.connection.close()
            print("🔒 Database connection closed.")
