check_errors(){
grep -i "error" /var/log/syslog
}
send_email(){
      local recipient="mdmabud.mail56@gmail.com"
      local subject="System Error Alert"
      local body=$(check_errors)
      echo "$body" |mail -s "$subject" "$recipient"
}
echo "Starting log monitoring..."
send_email
echo "Log monitoring completed."
