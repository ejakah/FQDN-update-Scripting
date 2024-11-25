# Install Azure CLI for Debian/Ubuntu:
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash  
# Authenticate with Azure CLI
az login
# Create the Directory
mkdir ~/dns-scripts
# List
ls
# Either nano or vi, past the script and save
nano update-dns.sh
# Make the Script Executable
chmod +x ~/dns-scripts/update-dns.sh
# Run the Script from the New Directory
./update-dns.sh
# Print current working environment
pwd
# Open the Cron Job Editor
crontab -e
# Verify Cron Jobs
crontab -l
# The Cron job run the script every 5 minutes, edit the directory
*/5 * * * * /home/ws/dns-scripts/update-dns.sh >> /home/ws/dns-scripts/dns-update.log 2>&1
# Monitoring the Script
# cd to return to /home/
cd

cat /home/ws/dns-scripts/dns-update.log
# verify the current IPV4 address 
curl -4 ifconfig.me
