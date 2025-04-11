# db_initializer.py

from db_connector import get_connection

def check_database_connection():
    conn = get_connection()
    if conn:
        print("✅ Database connection successful.")
        conn.close()
    else:
        print("❌ Failed to connect to the database.")

def list_existing_tables():
    conn = get_connection()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute("""
                SELECT TABLE_NAME 
                FROM INFORMATION_SCHEMA.TABLES 
                WHERE TABLE_TYPE = 'BASE TABLE'
            """)
            tables = cursor.fetchall()
            if tables:
                print("📋 Existing tables in SISDB:")
                for table in tables:
                    print(" -", table[0])
            else:
                print("⚠️ No tables found in the database.")
        except Exception as e:
            print("❌ Error fetching tables:", e)
        finally:
            conn.close()

def show_table_columns(table_name):
    conn = get_connection()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute(f"""
                SELECT COLUMN_NAME, DATA_TYPE 
                FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_NAME = ?
            """, (table_name,))
            columns = cursor.fetchall()
            if columns:
                print(f"📌 Columns in '{table_name}':")
                for col in columns:
                    print(f" - {col[0]} ({col[1]})")
            else:
                print(f"⚠️ No columns found for table '{table_name}'")
        except Exception as e:
            print(f"❌ Error fetching columns for table '{table_name}':", e)
        finally:
            conn.close()

# Run this script directly to test it
if __name__ == "__main__":
    check_database_connection()
    list_existing_tables()

    # Optional: Preview schema for a specific table
    show_table_columns("Students")
