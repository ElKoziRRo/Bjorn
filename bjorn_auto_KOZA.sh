#!/bin/bash

BJORN="$HOME/Bjorn"
WL="$BJORN/data/input/dictionary"

echo "=== AUTO: Skan sieci ==="
nmap -sV -O 192.168.1.0/24 -oN $BJORN/data/scan.txt

echo "=== AUTO: Generowanie loginów z hostnames ==="
bash generate_host_logins.sh
cp hostnames_users.txt "$WL/hostnames_users.txt"

echo "=== AUTO: Łączenie loginów ==="
cat "$WL/sql_users.txt" "$WL/hostnames_users.txt" | sort -u > "$WL/all_users.txt"

echo "=== AUTO: Uruchamianie Bjorn ==="
python3 $BJORN/main.py --auto

echo "=== AUTO: Raport ==="
date > $BJORN/data/last_run.txt

DATE=$(date)
HOSTS=$(cat data/scan.txt | grep "Nmap scan report")
SERVICES=$(cat data/scan.txt | grep "open")
RESULTS=$(cat data/logs/bjorn.log | grep SUCCESS)

sed -e "s/{{DATE}}/$DATE/" \
    -e "s/{{HOSTS}}/$HOSTS/" \
    -e "s/{{SERVICES}}/$SERVICES/" \
    -e "s/{{RESULTS}}/$RESULTS/" \
    -e "s/{{HOST_COUNT}}/$(echo "$HOSTS" | wc -l)/" \
    -e "s/{{SERVICE_COUNT}}/$(echo "$SERVICES" | wc -l)/" \
    -e "s/{{SUCCESS_COUNT}}/$(echo "$RESULTS" | wc -l)/" \
    data/output/template.html > data/output/last_report.html

