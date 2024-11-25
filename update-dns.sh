#!/bin/bash

# Azure DNS Zone Information
resource_group="sentics_internal"  # Your resource group
dns_zone="sentics.org"             # Your DNS zone
record_set_name="autodoc"          # The DNS record you're updating

# Get the public IP of the Linux machine
public_ip=$(curl -s http://ipinfo.io/ip)

# Check if the public IP was fetched successfully
if [[ -z "$public_ip" ]]; then
    echo "Failed to retrieve public IP address."
    exit 1
fi

# Update the A record in the Azure DNS Zone (without --ttl)
az network dns record-set a update \
  --resource-group "$resource_group" \
  --zone-name "$dns_zone" \
  --name "$record_set_name" \
  --set aRecords[0].ipv4Address="$public_ip"

# If the record set doesn't exist, create it with TTL
if [ $? -ne 0 ]; then
    az network dns record-set a add-record \
      --resource-group "$resource_group" \
      --zone-name "$dns_zone" \
      --record-set-name "$record_set_name" \
      --ipv4-address "$public_ip" --ttl 3600
fi

echo "DNS record for $record_set_name.$dns_zone updated to $public_ip"

