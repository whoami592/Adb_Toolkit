# ADB Toolkit - Bash Edition

**Coded by Cyber Security Engineer Mr Sabaz Ali Khan**

A menu-driven Bash toolkit for managing Android devices that you own or are authorized to administer through Android Debug Bridge (ADB).

## Features

- Detect and select connected ADB devices
- Show Android device information
- List user/system/all packages
- Install APK files
- Uninstall applications by package name
- Push files/folders to Android
- Pull files/folders from Android
- Take screenshots
- Record the Android screen
- Capture Logcat output
- Show battery, storage, and network details
- Open an interactive ADB shell
- Reboot normally, to recovery, or to bootloader
- Wireless ADB pairing/connect command guidance
- Save a local device report
- Restart the ADB server

## Requirements

- Bash 4+
- Android platform-tools / `adb`
- An Android device with Developer Options and USB debugging enabled
- Physical authorization of the computer on the Android device

## Install ADB

### Kali / Debian / Ubuntu

```bash
sudo apt update
sudo apt install adb -y
```

### Termux

```bash
pkg update
pkg install android-tools
```

## Run directly

```bash
chmod +x adb_toolkit.sh
./adb_toolkit.sh
```

## Install command globally for your user

```bash
chmod +x install.sh
./install.sh
```

Then run:

```bash
sabaz-adb
```

## Android preparation

1. Open **Settings > About phone**.
2. Tap **Build number** several times until Developer Options are enabled.
3. Open **Developer Options**.
4. Enable **USB debugging**.
5. Connect the phone to your computer with USB.
6. Accept the RSA authorization prompt on the phone.
7. Run `adb devices` and confirm the state is `device`.

## Output folders

The toolkit stores generated files under:

```text
~/ADB-Toolkit/
├── screenshots/
├── recordings/
├── logs/
└── pulled_files/
```

## Safety / authorization

Use this project only with devices you own or have explicit permission to manage. It intentionally does not include lock-screen bypasses, stealth surveillance, credential extraction, private-app data theft, SMS/call-log harvesting, or automated scanning for unknown wireless ADB devices.

## Credits

Coded by **Cyber Security Engineer Mr Sabaz Ali Khan**.
