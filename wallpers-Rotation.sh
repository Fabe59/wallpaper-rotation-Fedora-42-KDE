#!/bin/bash

SERVICE_NAME="wallpapers-rotation"
SCRIPT_PATH="/usr/local/bin/change-wallpaper.sh"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="$SYSTEMD_USER_DIR/${SERVICE_NAME}.service"
TIMER_FILE="$SYSTEMD_USER_DIR/${SERVICE_NAME}.timer"

function install() {
    echo "📦 Installation du script et du service '$SERVICE_NAME'..."

    mkdir -p "$SYSTEMD_USER_DIR"

    # Script principal
    cat << 'EOF' > "$SCRIPT_PATH"
#!/bin/bash

DAY_WALLPAPER="/usr/share/wallpapers/ScarletTree/contents/images/5120x2880.png"
NIGHT_WALLPAPER="/usr/share/wallpapers/ScarletTree/contents/images_dark/5120x2880.png"

if [ -n "$1" ]; then
    HOUR=$1
else
    HOUR=$(date +%H)
fi

if ! command -v plasma-apply-wallpaperimage &> /dev/null; then
    echo "Erreur : plasma-apply-wallpaperimage introuvable"
    exit 1
fi

if [ "$HOUR" -ge 8 ] && [ "$HOUR" -lt 20 ]; then
    WALLPAPER=$DAY_WALLPAPER
else
    WALLPAPER=$NIGHT_WALLPAPER
fi

plasma-apply-wallpaperimage "$WALLPAPER"
echo "Fond d'écran appliqué : $WALLPAPER"
EOF

    chmod +x "$SCRIPT_PATH"

    # Service systemd
    cat << EOF > "$SERVICE_FILE"
[Unit]
Description=Change KDE wallpaper automatically
After=graphical-session.target

[Service]
ExecStart=$SCRIPT_PATH
Type=oneshot
EOF

    # Timer systemd
    cat << EOF > "$TIMER_FILE"
[Unit]
Description=Wallpaper rotation every hour

[Timer]
OnStartupSec=0
OnBootSec=5min
OnUnitActiveSec=1h
Unit=${SERVICE_NAME}.service

[Install]
WantedBy=timers.target
EOF

    systemctl --user daemon-reload
    systemctl --user enable --now "${SERVICE_NAME}.timer"

    echo "✅ Installation terminée. Le fond d'écran sera mis à jour automatiquement."
}

function uninstall() {
    echo "🧹 Désinstallation du service '$SERVICE_NAME'..."

    systemctl --user disable --now "${SERVICE_NAME}.timer"
    rm -f "$SCRIPT_PATH" "$SERVICE_FILE" "$TIMER_FILE"
    systemctl --user daemon-reload

    echo "✅ Désinstallation terminée."
}

# Point d'entrée
if [ "$1" == "--uninstall" ]; then
    uninstall
else
    install
fi
