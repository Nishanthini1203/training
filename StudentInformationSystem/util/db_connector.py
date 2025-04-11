# db_connector.py
import pyodbc

def get_connection():
    try:
        conn = pyodbc.connect(
            'DRIVER={SQL Server};'
            'SERVER=NISHANTHINI\\NISHANTHINI;'  # Replace if needed
            'DATABASE=SISDB;'
            'Trusted_Connection=yes;'
        )
        return conn
    except pyodbc.Error as e:
        print("❌ Error connecting to the database:", e)
        return None
