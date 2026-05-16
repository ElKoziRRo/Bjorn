#!/bin/bash

echo "=== Instalacja wordlistów dla Bjorn ==="

# Katalog Bjorn – zmień jeśli masz inną lokalizację
BJORN_DIR="$HOME/Bjorn"
WORDLIST_DIR="$BJORN_DIR/data/input/dictionary"

echo "[1/8] Tworzenie katalogów..."
mkdir -p "$WORDLIST_DIR"

echo "[2/8] Instalacja pakietu wordlists (rockyou)..."
sudo apt update
sudo apt install -y wordlists

echo "[3/8] Rozpakowywanie rockyou.txt..."
if [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
    gunzip -k /usr/share/wordlists/rockyou.txt.gz
    cp /usr/share/wordlists/rockyou.txt "$WORDLIST_DIR/"
else
    echo "rockyou.txt.gz nie znaleziono — sprawdź pakiet wordlists."
fi

echo "[4/8] Tworzenie lekkich wersji rockyou..."
head -n 100 "$WORDLIST_DIR/rockyou.txt" > "$WORDLIST_DIR/top100.txt"
head -n 500 "$WORDLIST_DIR/rockyou.txt" > "$WORDLIST_DIR/top500.txt"
head -n 1000 "$WORDLIST_DIR/rockyou.txt" > "$WORDLIST_DIR/top1000.txt"
head -n 1000 "$WORDLIST_DIR/rockyou.txt" > "$WORDLIST_DIR/rockyou-1k.txt"

echo "[5/8] Tworzenie wordlistów protokołowych..."

# SSH
cat <<EOF > "$WORDLIST_DIR/ssh_common.txt"
root
admin
pi
user
test
1234
12345
123456
password
admin123
raspberry
EOF

# FTP
cat <<EOF > "$WORDLIST_DIR/ftp_default.txt"
anonymous
ftp
admin
admin123
password
1234
EOF

# SMB
cat <<EOF > "$WORDLIST_DIR/smb_pass.txt"
Admin123
Password1
Qwerty123
123456
Welcome1
P@ssw0rd
EOF

# SQL users
cat <<EOF > "$WORDLIST_DIR/sql_users.txt"
root
admin
mysql
user
test
EOF

# SQL passwords
cat <<EOF > "$WORDLIST_DIR/sql_passwords.txt"
root
admin
password
1234
12345
123456
mysql
EOF

# HTTP Basic Auth
cat <<EOF > "$WORDLIST_DIR/http_basic.txt"
admin
admin:admin
root:root
user:user
test:test
EOF

echo "[6/8] Nadawanie uprawnień..."
chmod -R 755 "$WORDLIST_DIR"

echo "[7/8] Podsumowanie:"
ls -lh "$WORDLIST_DIR"

echo "[8/8] Zakończono! Wordlisty gotowe do użycia w Bjorn."
