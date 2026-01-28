#!/system/bin/sh

echo "[LowRAM] === Rádio / Logs / Qualcomm ==="
su -c "resetprop persist.vendor.radio.add_power_save 1"
echo "[OK] radio power save"

su -c "resetprop persist.vendor.console.silent.config 1"
echo "[OK] vendor console silent"

su -c "resetprop persist.vendor.qcomsysd.enabled 0"
echo "[OK] qcomsysd desativado"

echo "[LowRAM] === Blur / UI / Scroll ==="
su -c "resetprop ro.sf.blurs_are_expensive 1"
echo "[OK] blur marcado como caro"

su -c "resetprop ro.surface_flinger.supports_background_blur 1"
echo "[OK] suporte a blur do SF"

su -c "resetprop ro.launcher.blur.appLaunch 0"
echo "[OK] blur no launch desativado"

su -c "resetprop ro.vendor.perf.scroll_opt true"
echo "[OK] scroll optimization"

echo "[LowRAM] === SurfaceFlinger Timing ==="
su -c "resetprop debug.sf.early_phase_offset_ns 11600000"
echo "[OK] early_phase_offset"

su -c "resetprop debug.sf.early_app_phase_offset_ns 11600000"
echo "[OK] early_app_phase_offset"

su -c "resetprop debug.sf.early_gl_phase_offset_ns 3000000"
echo "[OK] early_gl_phase_offset"

su -c "resetprop debug.sf.early_gl_app_phase_offset_ns 15000000"
echo "[OK] early_gl_app_phase_offset"

su -c "resetprop debug.sf.phase_offset_threshold_for_next_vsync_ns 11600000"
echo "[OK] vsync threshold"

echo "[LowRAM] === Background / LowRAM ==="
su -c "resetprop ro.vendor.qti.sys.fw.bg_apps_limit 600"
echo "[OK] bg apps limit vendor"

su -c "resetprop ro.config.low_ram true"
echo "[OK] low_ram mode"

su -c "resetprop ro.sys.fw.bg_apps_limit 48"
echo "[OK] bg apps limit system"

su -c "resetprop ro.sys.fw.use_trim_settings true"
echo "[OK] trim agressivo"

echo "[LowRAM] === LMK / Thrashing ==="
su -c "resetprop ro.lmk.use_minfree_levels true"
echo "[OK] LMK minfree"

su -c "resetprop ro.lmk.thrashing_limit 30"
echo "[OK] thrashing limit"

su -c "resetprop ro.lmk.thrashing_limit_decay 50"
echo "[OK] thrashing decay"

echo "[LowRAM] === ZRAM ==="
su -c "resetprop ro.zram.mark_idle_delay_mins 30"
echo "[OK] zram idle delay"

su -c "resetprop ro.zram.first_wb_delay_mins 60"
echo "[OK] zram first writeback"

echo "[LowRAM] === Display / SurfaceFlinger ==="
su -c "resetprop ro.sf.lcd_density 320"
echo "[OK] lcd density ajustada"

su -c "resetprop debug.sf.disable_backpressure 1"
echo "[OK] backpressure desativado"

echo "[LowRAM] === MGLRU ==="
su -c "setprop persist.device_config.mglru_native.lru_gen_config all"
echo "[OK] MGLRU config all"

su -c "echo 2000 > /sys/kernel/mm/lru_gen/min_ttl_ms"
echo "[OK] MGLRU min_ttl_ms = 2000"

su -c "settings put secure icon_blacklist airplane"
echo "[OK] Icone do modo avião foi ocultado"

su -c 'settings put global window_animation_scale 0.5'
su -c 'settings put global transition_animation_scale 0.5'
su -c 'settings put global animator_duration_scale 0.5'
echo "[Ok] Animações em 0.5"

echo "[LowRAM] Script finalizado com sucesso."
exit 0
