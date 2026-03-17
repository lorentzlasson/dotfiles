# troubleshoot monitor black screen

## problem

monitor intermittently goes black with kernel errors:
- `ucsi_acpi USBC000:00: unknown error 0`
- `ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-5)`
- `i2c_hid_acpi i2c-VEN_04F3:00: i2c_hid_get_input: incomplete report (14/65280)`

## investigation plan

1. identify hardware setup
   - which machine is affected (xps15, xps13, asus)?
   - monitor connection type (usb-c, displayport, hdmi)?
   - check if external dock/hub is involved

2. analyze kernel errors
   - ucsi_acpi: usb type-c connector system software interface failure
   - failed to get power delivery object specs (-5 = EIO error)
   - i2c_hid: touchpad/input device communication issue
   - determine if errors are correlated with monitor blackout

3. gather diagnostic data
   - check full dmesg output around blackout times
   - review journalctl for related subsystem errors
   - check if usb devices disconnect when monitor blacks out
   - monitor temps/power states during occurrence

4. potential causes
   - faulty usb-c cable or port
   - insufficient power delivery through usb-c
   - kernel driver issues with ucsi or i2c_hid
   - power management triggering unwanted suspend

5. test solutions
   - try different cable/port combination
   - disable usb autosuspend: `echo on > /sys/bus/usb/devices/*/power/control`
   - update/rollback kernel if recent change
   - blacklist problematic modules if identified
   - check nixos hardware quirks for specific laptop model

## findings

### hardware setup
- machine: xps15 (kernel 6.12.49, bios 1.18.0)
- connection: usb-c to displayport (DP-2)
- monitor status: connected and enabled
- internal display: eDP-1 (1920x1200)
- external display: DP-2 (2560x1440)

### root cause analysis
usb-c power delivery negotiation failure causes displayport signal drop:

1. ucsi_acpi driver fails to get power delivery objects (error -5 = EIO)
2. usb-c controller resets or drops connection during failed negotiation
3. displayport alternate mode signal drops
4. monitor goes black
5. i2c_hid touchpad errors occur as usb-c subsystem disrupts other buses

### likely causes (prioritized)
1. kernel driver bug in ucsi_acpi on 6.12.49 with this usb-c controller
2. faulty usb-c cable not implementing power delivery specs correctly
3. power management aggressively suspending usb-c ports
4. bios firmware 1.18.0 usb-c compatibility issues

### additional errors from screenshot (2026-03-17)
- UVC control failures: `usb 3-6: Failed to query (GET_INFO) UVC control 5 on unit 2: -71` (webcam, EPROTO)
- uvcvideo probe control failures: webcam driver can't initialize
- iwlwifi firmware hang: `timeout waiting for FW reset ACK (inta_in=0x1)`
- confirms USB-C failure cascades across entire USB bus (display, webcam, wifi)

### trigger pattern
- happens every time on wake from sleep
- first blackout immediately on wake
- second blackout after a few seconds of interaction
- requires logging in twice

### existing mitigations already in place
- `usbcore.autosuspend=-1` kernel param (didn't help)

## next steps

### attempt 1: disable nvidia finegrained power management
- changed `hardware.nvidia.powerManagement.finegrained` from `true` to `false`
- rationale: xps 15 9520 USB-C/Thunderbolt shares bus with dGPU. finegrained power management dynamically powers down the nvidia GPU, and on resume it may not power up fast enough, causing the UCSI controller to fail PD negotiation
- tradeoff: slightly higher idle power consumption
- rebuild with: `sudo nixos-rebuild switch --flake ~/dotfiles/nix`

### if attempt 1 fails
- try disabling nvidia power management entirely (`powerManagement.enable = false`)
- add udev rule to disable autosuspend specifically for UCSI controller
- check nixos-hardware dell-xps-15-9520 module for known workarounds
- test with a different USB-C cable
- check if newer kernel (beyond 6.12.49) fixes ucsi_acpi driver
