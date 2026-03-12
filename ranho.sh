#!/system/bin/sh

exec su -c sh <<'EOF'

echo "[Optimized] === Rádio / Qualcomm ==="
resetprop persist.vendor.radio.add_power_save 1
resetprop persist.vendor.console.silent.config 1
resetprop persist.vendor.qcomsysd.enabled 0


echo "[Optimized] === Memória (MGLRU) ==="
setprop persist.device_config.mglru_native.lru_gen_config all
echo 2000 > /sys/kernel/mm/lru_gen/min_ttl_ms


echo "[Optimized] === MIUI Scheduler ==="
setprop persist.sys.turbosched.enable true
setprop persist.sys.hyper_transition true
setprop persist.sys.miui_animator_sched.big_prime_cores true


echo "[Optimized] === MIUI Performance Levels ==="
service call miui.mqsas.IMQSNative 21 i32 1 s16 "setprop" i32 1 s16 "persist.sys.computility.cpulevel 6" s16 "/storage/emulated/0/log.txt" i32 600
service call miui.mqsas.IMQSNative 21 i32 1 s16 "setprop" i32 1 s16 "persist.sys.computility.gpulevel 6" s16 "/storage/emulated/0/log.txt" i32 600


echo "[Optimized] === SurfaceFlinger ==="
resetprop debug.sf.disable_backpressure 1
resetprop debug.sf.latch_unsignaled 1
resetprop debug.sf.use_phase_offsets_as_durations 1


echo "[Optimized] === SystemUI ==="
cmd appops set com.android.systemui RUN_IN_BACKGROUND allow
settings put secure icon_blacklist airplane


echo "[Optimized] === UI / Visual Engine ==="

service call miui.mqsas.IMQSNative 21 i32 1 s16 "setprop" i32 1 s16 "persist.sys.advanced_visual_release 3" s16 "/storage/emulated/0/log.txt" i32 600

settings put global disable_window_blurs 1
settings put secure reduce_motion 1
settings put global accessibility_reduce_transparency 1

# Possível conflito com disable_window_blurs
# setprop persist.sys.background_blur_supported true
# setprop persist.sys.background_blur_setting 2


echo "[Optimized] === HWUI ==="

# Flag antiga — geralmente ignorada nas versões modernas do Android
# setprop persist.sys.hwui.enable_texture_optimize true


echo "[Optimized] === Animações ==="
settings put global window_animation_scale 0.5
settings put global transition_animation_scale 0.5
settings put global animator_duration_scale 0.5


echo "[Optimized] === Apps em Background ==="
setprop persist.sys.mms.bg_apps_limit 48
setprop persist.sys.mmms.reclaim_switch 0


echo "[Optimized] Script aplicado com sucesso."

exit 0
EOF
