#!/system/bin/sh

idme_device_type_id=`/system/bin/cat /proc/idme/device_type_id`
echo "audio_sys_init: device_type_id: $idme_device_type_id" > /dev/kmsg

#Raven
case "$idme_device_type_id" in
    "A2JKHJ0PX4J3L3" )
        /system/bin/setprop sys.audio.bootanim "running"
        #dolby dma hal disable 0: enabled, 1: disabled
        /system/bin/setprop persist.dolby.dma.proxy.disable 0
        #dma continuous output devices (HDMI, BT)
        /system/bin/setprop persist.dolby.dma.devices.cm 1152
        #dma tunnel mode devices (HDMI, BT)
        /system/bin/setprop persist.dolby.dma.devices.tm 1152
        # tunnel mode audio pts adjust
        /system/bin/setprop tunnelmode.raw.apts.adjust -76
        /system/bin/setprop tunnelmode.pcm.apts.adjust 76
        # BT Tunnelmode audio pts adjust
        /system/bin/setprop tunnelmode.bt.apts.adjust -180

        # Audio pts adjust for AV sync fine tuning in non tunnel mode in DMA
        /system/bin/setprop apts_tune.non_tunnel_pcm 70
        /system/bin/setprop apts_tune.non_tunnel_dlb 50
        /system/bin/setprop apts_tune.non_tunnel_bt -120

        # AVLS specific usecase tuning, no impact on regular hdmi playback
        /system/bin/setprop apts_tune.non_tunnel.avls_pcm -30
        /system/bin/setprop apts_tune.non_tunnel.avls_dlb 0
        /system/bin/setprop apts_tune.tunnel.avls -300

        # AVLSU specific usecase tuning, no impact on regular hdmi playback
        /system/bin/setprop apts_tune.non_tunnel.avlsu_pcm 10
        /system/bin/setprop apts_tune.non_tunnel.avlsu_dlb 67
        /system/bin/setprop apts_tune.tunnel.avlsu -240
        ;;
    *)
        echo "audio_sys_init: unknown device_type_id - $idme_device_type_id" > /dev/kmsg
        ;;
esac

