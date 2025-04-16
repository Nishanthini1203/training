# DBConnUtil.py
import pyodbc

class DBConnUtil:

    @staticmethod
    def get_db_conn():
        # Directly provide the connection string
        conn_str = "Driver={SQL Server};Server=NISHANTHINI\\NISHANTHINI;Database=CODEC2;Trusted_Connection=yes;"
        conn = pyodbc.connect(conn_str)
        return conn
