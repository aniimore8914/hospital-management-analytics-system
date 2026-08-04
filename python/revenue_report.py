import pandas as pd
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345",
    database="hospital_project"
)

query = """
SELECT
    SUM(amount) AS total_revenue
FROM billing;
"""

df = pd.read_sql(query, conn)

print(df)


df.to_excel(
    "reports/revenue_report.xlsx",
    index=False
)

print("Report Generated Successfully!")

conn.close()