#!/bin/bash
source src/utils.sh

# ==============================
# Network Monitoring Functions
# ==============================

# 🌐 Check Network Interfaces
check_interfaces() {
    info "Fetching network interfaces..."
    if ip addr show > /tmp/interfaces_output.log 2>&1; then
        success "Interfaces listed successfully."
        dialog --textbox /tmp/interfaces_output.log 20 70
    else
        error "Failed to list interfaces."
    fi
}

# 🔍 Show Open Network Connections
show_connections() {
    info "Listing open network connections..."
    if ss -tuln > /tmp/connections_output.log 2>&1; then
        success "Open network connections displayed."
        dialog --textbox /tmp/connections_output.log 20 70
    else
        error "Failed to display connections."
    fi
}


packet_capture() {
    iface=$(dialog --inputbox "Enter interface for packet capture (e.g., eth0):" 8 50 3>&1 1>&2 2>&3 3>&-)

    if [ -z "$iface" ]; then
        error "Packet Capture: No interface provided."
        return
    fi

    info "Starting packet capture on $iface..."
    sudo tcpdump -i "$iface" -c 10 -w ~/packet_capture.pcap &> /tmp/tcpdump_output.log &
    PID=$!

    # Real-time display
    dialog --tailbox /tmp/tcpdump_output.log 20 70

    wait $PID
    if [ $? -eq 0 ]; then
        success "Packet capture completed successfully. Saved to ~/packet_capture.pcap"
    else
        error "Packet capture failed."
    fi
}


#🌐 HTTP Status Check
http_check() {
    url=$(dialog --inputbox "Enter URL to check HTTP status:" 8 50 3>&1 1>&2 2>&3 3>&-)

    if [ -z "$url" ]; then
        error "HTTP Check: No URL provided."
        return
    fi

    info "Fetching HTTP headers for $url..."
    if curl -I "$url" > /tmp/http_output.log 2>&1; then
        success "HTTP status fetched for $url."
        dialog --textbox /tmp/http_output.log 20 70
    else
        error "Failed to fetch HTTP status for $url."
        dialog --textbox /tmp/http_output.log 20 70
    fi
}
