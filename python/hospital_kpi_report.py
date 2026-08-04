import pandas as pd
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="12345",
    database="hospital_project"
)

kpis = []

# Total Revenue
query1 = "SELECT SUM(amount) FROM billing"
cursor = conn.cursor()
cursor.execute(query1)
total_revenue = cursor.fetchone()[0]

kpis.append(["Total Revenue", total_revenue])

# Average Bill
query2 = "SELECT AVG(amount) FROM billing"
cursor.execute(query2)
avg_bill = cursor.fetchone()[0]

kpis.append(["Average Bill", round(avg_bill, 2)])

# Total Patients
query3 = "SELECT COUNT(*) FROM patients"
cursor.execute(query3)
total_patients = cursor.fetchone()[0]

kpis.append(["Total Patients", total_patients])

# Total Doctors
query4 = "SELECT COUNT(*) FROM doctors"
cursor.execute(query4)
total_doctors = cursor.fetchone()[0]

kpis.append(["Total Doctors", total_doctors])

# Total Appointments
query5 = "SELECT COUNT(*) FROM appointment"
cursor.execute(query5)
total_appointments = cursor.fetchone()[0]

kpis.append(["Total Appointments", total_appointments])

df = pd.DataFrame(
    kpis,
    columns=["KPI", "Value"]
)

df.to_excel(
    "reports/Hospital_KPI_Report.xlsx",
    index=False
)

print(df)

cursor.close()
conn.close()

print("Hospital KPI Report Generated Successfully!")