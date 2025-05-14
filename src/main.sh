#!/bin/bash
source src/banner.sh
source src/diagnostics.sh
source src/monitoring.sh

# ==============================
#  Main Menu
# ==============================

while true; do
    # Main Menu - Alphabetical Tags
    choice=$(dialog --no-item-help --menu "Network Diagnostic Toolkit - Main Menu" 20 60 10 \
        "a" "Ping Test" \
        "b" "Trace Route" \
        "c" "DNS Lookup" \
        "d" "Port Scan (Nmap)" \
        "e" "Check Network Interfaces" \
        "f" "Show Open Network Connections" \
        "g" "Packet Capture (requires sudo)" \
        "h" "HTTP Status Check" \
        "i" "View Logs" \
        "j" "Exit" \
        3>&1 1>&2 2>&3 3>&-)

    case $choice in
        a) ping_test ;;
        b) trace_route ;;
        c) dns_lookup ;;
        d) port_scan ;;
        e) check_interfaces ;;
        f) show_connections ;;
        g) packet_capture ;;
        h) http_check ;;
        i) 
            if [ -f "$(pwd)/logs/toolkit.log" ]; then
                dialog --textbox "$(pwd)/logs/toolkit.log" 20 70
            else
                dialog --msgbox "No logs found." 6 40
            fi
            ;;
        j) 
            # Now customizing the buttons for consistency, and removing blinking
            dialog --no-item-help --yes-label "YES" --no-label "NO" --yesno "Are you sure you want to exit?" 7 50
            if [ $? -eq 0 ]; then
                clear
                exit 0
            fi
            ;;
        *) 
            dialog --msgbox "Invalid choice, please try again." 6 40
            ;;
    esac
done
