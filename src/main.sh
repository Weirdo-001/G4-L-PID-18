#!/bin/bash
source src/banner.sh
source src/diagnostics.sh
source src/utils.sh
LOG_PATH="./logs/toolkit.log"


show_banner



while true; do
    choice=$(dialog --clear --title "🌐 Network Diagnostic Toolkit - Main Menu" \
        --menu "Select an option:" 20 60 10 \
        "a" "Ping Test" \
        "b" "Trace Route" \
        "c" "DNS Lookup" \
        "d" "Port Scan" \
        "e" "Check Network Interfaces" \
        "f" "Show Open Network Connections" \
        "g" "Packet Capture" \
        "h" "HTTP Status Check" \
        "i" "View Logs" \
        "j" "Exit" \
        3>&1 1>&2 2>&3)

    if [ $? -ne 0 ]; then
        clear
        exit 0
    fi
clear
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
            if [ -f "$LOG_PATH" ]; then
                dialog --tailbox "$LOG_PATH" 20 70
            else
                dialog --msgbox "No logs found." 6 40
            fi
            ;;
        j) 
            dialog --clear
            dialog --title "🚪 Confirm Exit" \
                   --yes-label "Yes" --no-label "No" \
                   --yesno "Are you sure you want to exit?" 7 50
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
