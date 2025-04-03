Project Documentation: Log Monitoring System


Project Overview
This project involves creating a log monitoring script (log_monitor.sh) that scans /var/log/syslog for errors and sends email alerts when detected.

Features Implemented
✅ Error Detection: Scans system logs for "error" entries (case-insensitive).
✅ Email Notifications: Sends alerts to a specified email address.
✅ Error Handling: Checks if email delivery was successful.
✅ Cron Job Support: Can be scheduled for automated monitoring.

How It Works
The script runs grep -i "error" /var/log/syslog to check for errors.

If errors are found, they are formatted and sent via email.

If no errors are found, the script logs "No errors found."

The script provides success/failure feedback in the terminal.

Setup & Usage
1. Install Required Tools
bash
Copy
sudo apt update && sudo apt install mailutils -y
2. Create the Script (log_monitor.sh)
bash
Copy
nano log_monitor.sh
Paste the improved script and save (Ctrl+O → Enter → Ctrl+X).

3. Make It Executable
bash
Copy
chmod +x log_monitor.sh
4. Test the Script
bash
Copy
./log_monitor.sh
5. Schedule with Cron (Optional)
To run hourly:

bash
Copy
crontab -e
Add:

bash
Copy
0 * * * * /path/to/log_monitor.sh
Improved Script (log_monitor.sh)
bash
Copy
#!/bin/bash

check_errors() {
    grep -i "error" /var/log/syslog
}

send_email() {
    local recipient="mdnabud.mail560@gmail.com"
    local subject="System Error Alert"
    local body=$(check_errors)
    
    if [ -z "$body" ]; then
        echo "No errors found in syslog."
        return
    fi
    
    echo "$body" | mail -s "$subject" "$recipient"
    
    if [ $? -eq 0 ]; then
        echo "Email sent successfully to $recipient"
    else
        echo "Failed to send email" >&2
    fi
}

echo "Starting log monitoring..."
send_email
echo "Log monitoring completed."
