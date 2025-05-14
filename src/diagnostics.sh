#!/bin/bash
source src/utils.sh

# ==============================
#  Network Diagnostic Functions
# ==============================

# 🏓 Ping Test
ping_test() {
    host=$(dialog --inputbox "Enter hostname or IP to ping:" 8 50 3>&1 1>&2 2>&3 3>&-)
    
    if [ -z "$host" ]; then
        error "Ping Test: No hostname or IP provided."
        return
    fi

    info "Running Ping Test on $host..."
    if ping -c 4 "$host" > /tmp/ping_output.log 2>&1; then
        success "Ping to $host successful."
        dialog --textbox /tmp/ping_output.log 20 70
    else
        error "Ping to $host failed."
        dialog --textbox /tmp/ping_output.log 20 70
    fi
}

# 🌐 Trace Route
trace_route() {
    host=$(dialog --inputbox "Enter hostname or IP to trace:" 8 50 3>&1 1>&2 2>&3 3>&-)
    
    if [ -z "$host" ]; then
        error "Trace Route: No hostname or IP provided."
        return
    fi

    info "Running Trace Route on $host..."
    if traceroute "$host" > /tmp/traceroute_output.log 2>&1; then
        success "Trace to $host completed."
        dialog --textbox /tmp/traceroute_output.log 20 70
    else
        error "Trace to $host failed."
        dialog --textbox /tmp/traceroute_output.log 20 70
    fi
}

# 🔍 DNS Lookup
dns_lookup() {
    domain=$(dialog --inputbox "Enter domain to resolve:" 8 50 3>&1 1>&2 2>&3 3>&-)
    
    if [ -z "$domain" ]; then
        error "DNS Lookup: No domain provided."
        return
    fi

    info "Running DNS Lookup on $domain..."
    if dig "$domain" > /tmp/dns_output.log 2>&1; then
        success "DNS lookup for $domain successful."
        dialog --textbox /tmp/dns_output.log 20 70
    else
        error "DNS lookup for $domain failed."
        dialog --textbox /tmp/dns_output.log 20 70
    fi
}

# 🔎 Port Scan
port_scan() {
    target=$(dialog --inputbox "Enter target IP or domain for port scan:" 8 50 3>&1 1>&2 2>&3 3>&-)
    
    if [ -z "$target" ]; then
        error "Port Scan: No target provided."
        return
    fi

    info "Running Port Scan on $target..."
    if nmap -Pn "$target" > /tmp/portscan_output.log 2>&1; then
        success "Port scan for $target completed."
        dialog --textbox /tmp/portscan_output.log 20 70
    else
        error "Port scan for $target failed."
        dialog --textbox /tmp/portscan_output.log 20 70
    fi
}

