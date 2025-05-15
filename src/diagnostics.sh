#!/bin/bash
source src/utils.sh

ping_test() {
    host=$(dialog --inputbox "Enter hostname or IP to ping:" 8 50 3>&1 1>&2 2>&3)
    if [ $? -ne 0 ] || [ -z "$host" ]; then
        error "Ping Test: No hostname or IP provided."
        return
    fi
    info "Running Ping Test on $host..."
    if ping -c 4 "$host" > /tmp/ping_output.log 2>&1; then
        success "Ping to $host successful."
    else
        error "Ping to $host failed."
    fi
    dialog --tailbox /tmp/ping_output.log 20 70
    rm -f /tmp/ping_output.log
}

trace_route() {
    host=$(dialog --inputbox "Enter hostname or IP to trace:" 8 50 3>&1 1>&2 2>&3)
    if [ $? -ne 0 ] || [ -z "$host" ]; then
        error "Trace Route: No hostname or IP provided."
        return
    fi
    info "Running Trace Route on $host..."
    if traceroute "$host" > /tmp/traceroute_output.log 2>&1; then
        success "Trace to $host completed."
    else
        error "Trace to $host failed."
    fi
    dialog --tailbox /tmp/traceroute_output.log 20 70
    rm -f /tmp/traceroute_output.log
}

dns_lookup() {
    domain=$(dialog --inputbox "Enter domain to resolve:" 8 50 3>&1 1>&2 2>&3)
    if [ $? -ne 0 ] || [ -z "$domain" ]; then
        error "DNS Lookup: No domain provided."
        return
    fi
    info "Running DNS Lookup on $domain..."
    if dig "$domain" > /tmp/dns_output.log 2>&1; then
        success "DNS lookup for $domain successful."
    else
        error "DNS lookup for $domain failed."
    fi
    dialog --tailbox /tmp/dns_output.log 20 70
    rm -f /tmp/dns_output.log
}

port_scan() {
    target=$(dialog --inputbox "Enter target IP or domain for port scan:" 8 50 3>&1 1>&2 2>&3)
    if [ $? -ne 0 ] || [ -z "$target" ]; then
        error "Port Scan: No target provided."
        return
    fi
    info "Running Port Scan on $target..."
    if nmap -Pn "$target" > /tmp/portscan_output.log 2>&1; then
        success "Port scan for $target completed."
    else
        error "Port scan for $target failed."
    fi
    dialog --tailbox /tmp/portscan_output.log 20 70
    rm -f /tmp/portscan_output.log
}
check_interfaces() {
    info "Fetching network interfaces..."
    ip addr show > /tmp/interfaces_output.log 2>&1
    dialog --tailbox /tmp/interfaces_output.log 20 70
    rm -f /tmp/interfaces_output.log
}

show_connections() {
    info "Listing open network connections..."
    ss -tuln > /tmp/connections_output.log 2>&1
    dialog --tailbox /tmp/connections_output.log 20 70
    rm -f /tmp/connections_output.log
}
packet_capture() {
    iface=$(dialog --inputbox "Enter interface for packet capture (e.g., eth0):" 8 50 3>&1 1>&2 2>&3)
    if [ -z "$iface" ]; then
        error "Packet Capture: No interface provided."
        return
    fi

    info "Starting packet capture on $iface..."

    # Run tcpdump with limited count and output to a text file for dialog tailbox
    sudo tcpdump -i "$iface" -c 20 > /tmp/tcpdump_output.log 2>&1 &
    PID=$!

    # Show tailbox of output log while tcpdump runs
    dialog --title "Packet Capture Output" --tailbox /tmp/tcpdump_output.log 20 70

    # Wait for tcpdump to finish
    wait $PID
    if [ $? -eq 0 ]; then
        success "Packet capture completed successfully."
    else
        error "Packet capture failed."
    fi
}

http_check() {
    url=$(dialog --inputbox "Enter URL to check HTTP status:" 8 50 3>&1 1>&2 2>&3)
    if [ -z "$url" ]; then
        error "HTTP Check: No URL provided."
        return
    fi
    info "Fetching HTTP headers for $url..."
    curl -I "$url" > /tmp/http_output.log 2>&1
    dialog --tailbox /tmp/http_output.log 20 70
    rm -f /tmp/http_output.log
}
