#!/usr/bin/env bash

set -o pipefail

echo "======================================="
echo "     SHOGUN DEPENDENCY INSTALLER"
echo "======================================="

# ------------------------------
# OS Detection
# ------------------------------

OS_TYPE="$(uname -s 2>/dev/null)"

case "$OS_TYPE" in
    Linux*)     PLATFORM="linux" ;;
    Darwin*)    PLATFORM="macos" ;;
    MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
    *)          PLATFORM="unknown" ;;
esac

echo "[+] OS Detected: $PLATFORM"

# ------------------------------
# Python Detection
# ------------------------------

PYTHON_BIN=""

if command -v python3 >/dev/null 2>&1; then
    PYTHON_BIN="python3"
elif command -v python >/dev/null 2>&1; then
    PYTHON_BIN="python"
else
    echo "[!] Python not found in PATH."
    exit 1
fi

echo "[+] Python binary: $PYTHON_BIN"

# ------------------------------
# Python Version Check
# ------------------------------

PY_VERSION=$($PYTHON_BIN -c "import sys; print(sys.version_info.major, sys.version_info.minor)" 2>/dev/null)

if [ $? -ne 0 ]; then
    echo "[!] Unable to read Python version."
    exit 1
fi

MAJOR=$(echo $PY_VERSION | awk '{print $1}')
MINOR=$(echo $PY_VERSION | awk '{print $2}')

if [ "$MAJOR" -lt 3 ]; then
    echo "[!] Python 3.8+ required."
    exit 1
fi

echo "[+] Python version OK ($MAJOR.$MINOR)"

# ------------------------------
# Ensure pip Available
# ------------------------------

if ! $PYTHON_BIN -m pip --version >/dev/null 2>&1; then
    echo "[!] pip not found. Attempting ensurepip..."
    $PYTHON_BIN -m ensurepip --upgrade 2>/dev/null || {
        echo "[!] Failed to bootstrap pip."
        exit 1
    }
fi

echo "[+] pip ready"

# ------------------------------
# Upgrade pip Safely
# ------------------------------

echo "[+] Upgrading pip..."

$PYTHON_BIN -m pip install --upgrade pip --quiet || {
    echo "[!] pip upgrade failed (non-critical). Continuing..."
}

# ------------------------------
# Install Dependencies
# ------------------------------

DEPENDENCIES=("rich" "requests")

for pkg in "${DEPENDENCIES[@]}"; do
    echo "[+] Installing $pkg ..."
    
    $PYTHON_BIN -m pip install "$pkg" --quiet
    
    if [ $? -ne 0 ]; then
        echo "[!] First attempt failed for $pkg. Retrying..."
        sleep 2
        $PYTHON_BIN -m pip install "$pkg"
        
        if [ $? -ne 0 ]; then
            echo "[!] Failed to install $pkg after retry."
            exit 1
        fi
    fi

    echo "[+] $pkg installed successfully."
done

# ------------------------------
# Validate Python Modules
# ------------------------------

echo "[+] Validating modules..."

$PYTHON_BIN - <<EOF
import sys

errors = []

try:
    import rich
except Exception as e:
    errors.append(f"rich import failed: {e}")

try:
    import requests
except Exception as e:
    errors.append(f"requests import failed: {e}")

try:
    import json
except Exception as e:
    errors.append(f"json import failed: {e}")

try:
    import ssl
except Exception as e:
    errors.append(f"ssl import failed: {e}")

if errors:
    print("[!] Module validation errors detected:")
    for err in errors:
        print("   -", err)
    sys.exit(1)
else:
    print("[+] All modules validated successfully.")
EOF

if [ $? -ne 0 ]; then
    echo "[!] Dependency validation failed."
    exit 1
fi

echo "======================================="
echo "[✓] All dependencies installed correctly."
echo "======================================="
