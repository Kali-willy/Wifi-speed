#!/system/bin/sh
# Wi-Fi/Network Booster Script
# Developer: Willy Jr Caransa Gailo

# Function para sa loading animation
show_loading() {
    local pid=$1
    local delay=0.2
    local spinstr='|/-\'
    while [ "$(ps | grep $pid | grep -v grep)" ]; do
        for i in $(seq 0 3); do
            echo -ne "\r${spinstr:$i:1} Applying network optimizations... "
            sleep $delay
        done
    done
    echo -e "\r✓ Successfully applied!                   "
}

# Header design
clear
echo "============================================"
echo "   📶 Wi-Fi / Network Booster Script 🚀"
echo "   Developer: Willy Jr Caransa Gailo"
echo "============================================"
echo ""

# I-boost ang TCP/IP settings (background process para sa loading)
(
    settings put global tcp_default_init_rwnd 60
    settings put global wifi_scan_always_enabled 1

    # Mas agresibo na signal handover
    settings put global wifi_watchdog_on 0
    settings put global wifi_supplicant_scan_interval 90

    # DNS mas mabilis (Google DNS)
    settings put global private_dns_mode hostname
    settings put global private_dns_specifier dns.google

    # Optional: i-restart ang Wi-Fi para mas epektibo (kung gusto mo, pwede i-uncomment)
    # svc wifi disable
    # sleep 1
    # svc wifi enable
) &
show_loading $!

# Final message
echo ""
echo "✨ Your device is now optimized for faster Wi-Fi and network performance!"
echo "💡 Tip: Reboot your device for best results."
echo ""
echo "============================================"