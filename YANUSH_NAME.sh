#!/bin/bash

# Nowa nazwa
NEW="YanusH"

# Stara nazwa
OLD="Bjorn"

# Katalog projektu (zmień jeśli masz inną ścieżkę)
DIR="$HOME/Bjorn"

echo "=== Zmiana nazwy $OLD → $NEW w całym projekcie ==="

# 1. Zmiana w plikach .py, .json, .sh, .txt
find "$DIR" -type f \( -name "*.py" -o -name "*.json" -o -name "*.sh" -o -name "*.txt" \) \
    -exec sed -i "s/$OLD/$NEW/g" {} +

echo "[OK] Zmieniono nazwy w plikach"

# 2. Zmiana nazw plików statusu
if [ -f "$DIR/config/bjornstatus.json" ]; then
    mv "$DIR/config/bjornstatus.json" "$DIR/config/${NEW,,}status.json"
    echo "[OK] Zmieniono bjornstatus.json → ${NEW,,}status.json"
fi

if [ -f "$DIR/config/livestatus.json" ]; then
    mv "$DIR/config/livestatus.json" "$DIR/config/${NEW,,}_livestatus.json"
    echo "[OK] Zmieniono livestatus.json → ${NEW,,}_livestatus.json"
fi

echo "=== Zakończono ==="
echo "Nowa nazwa urządzenia: $NEW"
