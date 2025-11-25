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

## next steps

start with step 1 to identify exact hardware configuration
