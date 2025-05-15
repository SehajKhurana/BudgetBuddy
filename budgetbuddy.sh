#!/bin/bash

# BudgetBuddy - Expense Tracker CLI

# Colors
green=$(tput setaf 2)
red=$(tput setaf 1)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

# Expense file and Backup directory
DATA_FILE="expenses.csv"
BACKUP_DIR="$HOME/BudgetBuddy_Backup"

# Authentication function
authenticate_user() {
    PASSWORD="admin123"
    read -s -p "Enter Password: " input_pass
    echo
    if [ "$input_pass" != "$PASSWORD" ]; then
        echo "${red}Authentication Failed! Exiting...${reset}"
        sleep 1
        clear
        exit 1
    fi
}

# Initialize expenses.csv if not already present
init_data_file() {
    if [ ! -f "$DATA_FILE" ]; then
        echo "Amount,Type,Category,Date" > "$DATA_FILE"
    fi
}

# Validate numeric input
validate_amount() {
    if [[ ! "$1" =~ ^[0-9]+(\.[0-9]{1,2})?$ ]]; then
        return 1
    fi
    return 0
}

# Add income or expense
add_entry() {
    type=$1
    amount=$(dialog --stdout --inputbox "Enter Amount (₹):" 8 40)
    category=$(dialog --stdout --inputbox "Enter Category (e.g., Food, Salary, Shopping):" 8 40)
    date=$(date +%F)

    if [[ -n "$amount" && -n "$category" ]]; then
        if ! validate_amount "$amount"; then
            echo "${red}Amount must be a number.${reset}"
            return
        fi
        ( 
            flock -n 9 || exit 1
            echo "$amount,$type,$category,$date" >> "$DATA_FILE"
        ) 9>"$LOCK_FILE"
        echo "${green}$type recorded successfully!${reset}"
    else
        echo "${red}Invalid input.${reset}"
    fi
}

# Generate and display expense summary
generate_summary() {
    clear
    echo "${yellow}--- Monthly Expense Summary ---${reset}"
    if [[ -s "$DATA_FILE" ]]; then
        awk -F',' 'NR>1 {a[$3]+=$1} END {for (i in a) printf "%-15s : ₹%d\n", i, a[i]}' "$DATA_FILE"
    else
        echo "${red}No expense records found.${reset}"
    fi
    echo
    read -p "Press Enter to continue..."
}

# Show total income, expense, and balance
show_balance() {
    total_income=$(awk -F',' '$2=="income" {sum+=$1} END {print sum+0}' "$DATA_FILE")
    total_expense=$(awk -F',' '$2=="expense" {sum+=$1} END {print sum+0}' "$DATA_FILE")
    balance=$((total_income - total_expense))

    clear
    echo "${green}Income: ₹$total_income${reset}"
    echo "${red}Expenses: ₹$total_expense${reset}"
    echo "${yellow}Balance: ₹$balance${reset}"
    echo
    read -p "Press Enter to continue..."
}

# Backup data to backup folder
backup_data() {
    mkdir -p "$BACKUP_DIR"
    backup_file="$BACKUP_DIR/expenses_$(date +%F_%H-%M-%S).csv"
    cp "$DATA_FILE" "$backup_file"
    chmod 600 "$backup_file"
    echo "${green}Backup created: $backup_file${reset}"
}

# Export data to a PDF report
export_report_pdf() {
    if ! command -v enscript &> /dev/null || ! command -v ps2pdf &> /dev/null; then
        echo "${red}Please install 'enscript' and 'ps2pdf' to export PDF reports.${reset}"
        return
    fi
    enscript "$DATA_FILE" -o - | ps2pdf - "expenses_report.pdf"
    echo "${green}PDF report generated: expenses_report.pdf${reset}"
}

# Display the main menu
main_menu() {
    while true; do
        choice=$(dialog --stdout --menu "BudgetBuddy - Main Menu" 15 50 7 \
            1 "Add Income" \
            2 "Add Expense" \
            3 "View Summary" \
            4 "Show Balance" \
            5 "Backup Data" \
            6 "Export PDF Report" \
            7 "Exit")

        # Exit if user presses ESC or cancels
        if [ $? -ne 0 ]; then
            goodbye
        fi

        case "$choice" in
            1) add_entry "income" ;;
            2) add_entry "expense" ;;
            3) generate_summary ;;
            4) show_balance ;;
            5) backup_data ;;
            6) export_report_pdf ;;
            7) goodbye ;;
            *) goodbye ;;
        esac
    done
}

# Goodbye message and cleanup
goodbye() {
    clear
    echo "${yellow}Thank you for using BudgetBuddy! Have a great day!${reset}"
    sleep 1
    clear
    exit 0
}

# --- Start of Script ---

authenticate_user
init_data_file
main_menu
