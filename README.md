# BudgetBuddy - Expense Tracker for Students

> A lightweight, secure, and interactive CLI-based expense tracker built using Bash, packaged with Docker, and protected with basic firewall rules. Designed especially for students to manage their income and expenses with ease.

---

##  Features

-  **Password-Protected Login**
-  **Add Income & Expenses**
-  **View Category-Wise Expense Summary**
-  **Real-Time Balance Calculation**
-  **CSV-Based Data Storage**
-  **Data Backup with Timestamp**
-  **Export Report to PDF**
-  **Dockerized for Portability**
-  **Firewall Script for Basic Security**

---

##  Technologies Used

- **Bash Scripting**
- **Dialog (CLI UI)**
- **CSV for Storage**
- **Enscript & Ghostscript** (for PDF Export)
- **Docker** (for containerization)
- **UFW (Uncomplicated Firewall)** for network security

---

##  File Structure

```bash
.
├── budgetbuddy.sh          # Main application script
├── Dockerfile              # Dockerfile to containerize the app
├── firewall-setup.sh       # Script to set basic firewall rules
├── expenses.csv            # CSV file where data is stored
├── expenses_report.pdf     # Auto-generated report (after export)
└── README.md               # Project documentation
```
How to Run the Project:
Firewall Setup 
```bash
# Step 1: Give permission
chmod +x firewall-setup.sh

# Step 2: Run the firewall script (requires sudo)
sudo ./firewall-setup.sh
```
This script:

Enables UFW

Allows only ports 22 (SSH), 80 (HTTP), and 443 (HTTPS)

Denies all other ports

Option 1: Run Directly on Linux
```bash
# Step 1: Give permission
chmod +x budgetbuddy.sh

# Step 2: Run the application
./budgetbuddy.sh
```
Option 2: Run via Docker
```bash
# Step 1: Build Docker image
docker build -t budgetbuddy .

# Step 2: Run the container
docker run -it budgetbuddy
```

Sample Use Cases:
Add Income → Adds an income record into the CSV.

Add Expense → Categorized logging of expenses.

View Summary → Category-wise expense display.

Show Balance → Net balance calculated (Income - Expenses).

Backup Data → Safely backs up CSV with timestamp.

Export PDF Report → Creates a print-ready financial report.

Sample Entry in expenses.csv:
```csv
Amount,Type,Category,Date
5000,income,Scholarship,2025-05-12
200,expense,Snacks,2025-05-13
```
Requirements:
Ensure the following are installed (for full functionality):

dialog

enscript

ghostscript

docker

ufw

💡 Missing packages will be automatically installed in the Docker container.
