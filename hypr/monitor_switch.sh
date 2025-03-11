#!/bin/bash

# Función para verificar si un monitor está conectado
is_monitor_connected() {
    hyprctl monitors | grep -q "$1"
}

# Obtener los monitores disponibles
INTERNAL_MONITOR="eDP-1"
EXTERNAL_MONITOR="HDMI-A-1"

# Función para reiniciar waybar
restart_waybar() {
    # Intentar reiniciar waybar de múltiples maneras
    pkill waybar
    sleep 0.5
    waybar &
}

# Lógica de cambio de monitor
toggle_monitor() {
    if is_monitor_connected "$EXTERNAL_MONITOR"; then
        # Si el monitor externo está activo, cambiar la configuración
        if is_monitor_connected "$INTERNAL_MONITOR"; then
            # Deshabilitar monitor interno y usar solo externo
            hyprctl keyword monitor "$INTERNAL_MONITOR", disable
            hyprctl keyword monitor "$EXTERNAL_MONITOR", 2560x1080@60, 0x0, 1
            notify-send "Monitor" "Usando solo monitor externo HDMI"
        else
            # Habilitar monitor interno y configurar monitores
            hyprctl keyword monitor "$INTERNAL_MONITOR", 1920x1080@60, 0x0, 1
            hyprctl keyword monitor "$EXTERNAL_MONITOR", 2560x1080@60, 1920x0, 1
            notify-send "Monitor" "Usando monitor interno y externo"
        fi
    else
        # Si no hay monitor externo, usar solo el interno
        hyprctl keyword monitor "$INTERNAL_MONITOR", 1920x1080@60, 0x0, 1
        notify-send "Monitor" "Usando solo monitor interno"
    fi

    # Reiniciar waybar
    restart_waybar
}

# Ejecutar la función de cambio de monitor
toggle_monitor
