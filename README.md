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

