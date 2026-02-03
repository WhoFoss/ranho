#!/system/bin/sh

exec su -c sh <<'EOF'

echo "[LowLag] === Rádio / Logs / Qualcomm ==="
resetprop persist.vendor.radio.add_power_save 1
resetprop persist.vendor.console.silent.config 1
resetprop persist.vendor.qcomsysd.enabled 0
echo "[OK] rádio e logs ajustados"

echo "[LowLag] === UI / Blur / Efeitos ==="
resetprop ro.sf.blurs_are_expensive 1
settings put global disable_window_blurs 1
settings put secure reduce_motion 1
settings put global accessibility_reduce_transparency 1
echo "[OK] blur e efeitos reduzidos"

echo "[LowLag] === SurfaceFlinger / Frames ==="
resetprop debug.sf.latch_unsignaled 1
resetprop debug.sf.disable_backpressure 1
resetprop debug.sf.use_phase_offsets_as_durations 1
echo "[OK] SF pipeline otimizado"

echo "[LowLag] === HWUI / GPU ==="
setprop debug.hwui.renderer skiagl
setprop debug.hwui.use_buffer_age true
setprop debug.hwui.disable_vsync false
echo "[OK] HWUI balanceado GPU-first"

echo "[LowLag] === Animações ==="
settings put global window_animation_scale 0.5
settings put global transition_animation_scale 0.5
settings put global animator_duration_scale 0.5
echo "[OK] animações 0.5x"

echo "[LowLag] === LMK / Memória ==="
resetprop ro.lmk.use_minfree_levels true
resetprop ro.lmk.thrashing_limit 30
resetprop ro.lmk.thrashing_limit_decay 50
echo "[OK] LMK estável (sem agressividade burra)"

echo "[LowLag] === MGLRU ==="
setprop persist.device_config.mglru_native.lru_gen_config all
echo 2000 > /sys/kernel/mm/lru_gen/min_ttl_ms
echo "[OK] MGLRU configurado"

echo "[LowLag] === SystemUI ==="
cmd appops set com.android.systemui RUN_IN_BACKGROUND allow
settings put secure icon_blacklist airplane
echo "[OK] SystemUI protegida"

echo "[LowLag] Script aplicado com sucesso."
exit 0
EOF
