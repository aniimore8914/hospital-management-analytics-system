import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345",
    database="hospital_project"
)

print("Database Connected Successfully!")

conn.close()

