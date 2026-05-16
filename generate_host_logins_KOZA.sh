#!/bin/bash

NET="192.168.1.0/24"
OUT="hostnames_users.txt"

echo "=== Pobieranie hostnames z sieci ==="
nmap -sn $NET | grep "Nmap scan report" | awk '{print $5}' > raw_hosts.txt

echo "=== Generowanie loginów z hostnames ==="
> "$OUT"

while read host; do
    base=$(echo "$host" | tr '[:upper:]' '[:lower:]')

    echo "$base" >> "$OUT"
    echo "${base}1" >> "$OUT"
    echo "${base}123" >> "$OUT"
    echo "${base}_admin" >> "$OUT"
    echo "admin_$base" >> "$OUT"
done < raw_hosts.txt

sort -u "$OUT" -o "$OUT"

echo "Wygenerowano: $OUT"
