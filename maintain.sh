#!/bin/bash

disk_usage_check() {
    echo "log warning"
}

disk_log_warning() {
    echo "check logs"
}

clean_temp_files_3() {
    sudo find /tmp -type f -atime +3 -delete
}

large_logs() {
    echo "Top 3 large logs:"
    sudo find /var/log -type f -name "*.log" -size +10M -exec du -h {} + 2>/dev/null | sort -hr | head -n 3
}


audit_report() {
    if [ ! -d "$AUDIT_DIR" ]; then
        sudo mkdir -p "$AUDIT_DIR"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - created missing directory: $AUDIT_DIR" | sudo tee -a /var/log/audit_fallback.log >/dev/null
    fi

    {
        echo "Report"
        echo "Date:  $(date '+%Y-%m-%d %H:%M:%S')"
        echo ">> Disk Usage:"
        df -h
        echo ""
        echo "Top 3 Largest .log Files in /var/log (Over 10MB):"
        sudo find /var/log -type f -name "*.log" -size +10M -exec du -h {} + 2>/dev/null | sort -hr | head -n 3
        echo ""
        echo "Users using more than 500MB of memory:"
        ps -eo user,rss | awk 'NR>1 && $2 > 512000' | sort -k2 -nr
    } | sudo tee "$REPORT_FILE" > /dev/null
}

AUDIT_DIR="/opt/audit"
REPORT_FILE="$AUDIT_DIR/summary.txt"
LOG_FILE="$AUDIT_DIR/audit.log"

if df -h | awk '$5+0 >= 10 {print $1, $5}' | grep -q .; then
    disk_usage_check
    clean_temp_files_3
fi

large_logs
audit_report
sudo cp /opt/audit/summary.txt .
