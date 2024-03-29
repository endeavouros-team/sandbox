Table of Contents

1. [Intel RST](driver-tips.md#Intel_RST)
2. [Realtek 8168](driver-tips.md#Realtek_8168)

# Driver tips

Here is a small collection of tips related to various drivers.

## Intel_RST

If your machine does not have Intel RST / Optane technology, you can disable the `vmd` kernel module by removing word **vmd** from the MODULES variable in file `/etc/mkinitcpio.conf`.<br>
To do so, change line
```
MODULES=(vmd)
```
to
```
MODULES=()
```
Then run command
```
sudo mkinitcpio -P
```
and reboot.

To check that the kernel module has been disabled, the following command should give no output:<br>
```
lsmod | grep vmd
```

## Realtek_8168

This applies to machines with the Realtek 8168 Ethernet controller.
Linux kernel includes a driver `r8169` by default. Some (new) machines *may* require the `r8168` driver package.

EndeavourOS has by default installed package r8168, but blacklisted the driver, so the r8169 should be in use by default.

To check which driver is in use, run command
```
lsmod | grep -Pw 'r8168|r8169'
```

If your machine has problems with the Ethernet connection, blacklist either r8169 or r8168 and reboot.<br>
Blacklisting can be done in file `/usr/lib/modprobe.d/r8168.conf`.

Another simple action is to
- reinstall package r8168<br>
  or
- uninstall package r8168

and reboot.
