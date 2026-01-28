# Android Auto Mirror

A powerful Android application that enables screen mirroring from your Samsung Galaxy S24 Ultra (or any Android device) to your car's Android Auto display. Stream content from your phone to your car's screen.

## 🚨 Platform Change

**This app has been completely rebuilt for Android devices, specifically optimized for the Samsung Galaxy S24 Ultra.**

### What Changed:
- ❌ **No longer supports iPhone/CarPlay** (original iOS version removed)
- ✅ **Now supports Android/Android Auto** (complete rewrite)
- ✅ **Optimized for Samsung Galaxy S24 Ultra**
- ✅ **Works with any Android 9.0+ device**

## Features

- 🚗 **Full Android Auto Integration**: Seamless integration with your car's Android Auto system
- 📱 **Screen Capture**: Capture your entire Android screen using MediaProjection API
- 🎬 **Stream Content**: View photos, compatible videos, and apps on your car display
- 🎮 **Easy Control**: Simple start/stop controls from both phone and Android Auto interface
- 🔒 **Privacy & Security**: Uses Android's secure MediaProjection framework
- ⚡ **Real-time Capture**: Low-latency screen capture for smooth viewing

## Requirements

### Device Requirements:
- **Samsung Galaxy S24 Ultra** (or any Android device)
- **Android 9.0 (Pie) or later**
- **At least 2GB RAM**
- **Android Auto app installed**

### Car Requirements:
- **Car with Android Auto capability** (wired or wireless)
- **USB-C cable** for wired connection (or wireless Android Auto support)

### Development Requirements (to build the app):
- **Android Studio** (latest version recommended)
- **Computer** (Windows, Mac, or Linux)
- **USB cable** to connect phone to computer

## Quick Installation Guide

### For Complete Beginners:
👉 **See [BEGINNER_INSTALL_GUIDE.md](BEGINNER_INSTALL_GUIDE.md)** for detailed step-by-step instructions with screenshots and troubleshooting.

### For Developers:

1. **Clone the repository**:
```bash
git clone https://github.com/S3OPS/Carplay.git
cd Carplay/AndroidAutoMirror
```

2. **Open in Android Studio**:
   - Launch Android Studio
   - File → Open → Select `AndroidAutoMirror` folder
   - Wait for Gradle sync

3. **Connect your Android device**:
   - Enable Developer Options (tap Build Number 7 times)
   - Enable USB Debugging
   - Connect via USB

4. **Build and Run**:
   - Click the green play button (▶️)
   - App installs and launches automatically

## Usage

### Initial Setup

1. **Grant Permissions**:
   - Audio recording (for capturing app audio)
   - Screen capture (system permission)

2. **Connect to Android Auto**:
   - Wired: USB-C cable from phone to car
   - Wireless: Pair via Bluetooth, enable in Android Auto settings

### Starting Screen Mirroring

**From Your Phone:**
1. Open "Android Auto Mirror" app
2. Tap "Start Mirroring"
3. Grant screen capture permission
4. Status shows "Mirroring Active 🟢"

**From Android Auto:**
1. In your car, open Android Auto
2. Find "Android Auto Mirror" in the app list
3. Tap "Start Screen Mirroring"
4. Follow prompts on phone

### Viewing Content

Once mirroring is active:
- Open Photos app to view pictures
- Open YouTube for videos (some content)
- Browse web with Chrome
- Use any compatible app

**⚠️ DRM LIMITATION:**
- Netflix, Disney+, HBO Max, and similar services use DRM (Digital Rights Management)
- DRM-protected content will show as a **black screen**
- This is a security feature, not a bug
- Compatible with: Photos, YouTube (non-DRM), web browsers, games

### Stopping Mirroring

- Tap "Stop Mirroring" in the app
- OR tap Stop from notification
- OR stop from Android Auto interface

## Project Structure

```
AndroidAutoMirror/
├── app/
│   ├── src/main/
│   │   ├── java/com/s3ops/androidautomirror/
│   │   │   ├── MainActivity.kt              # Main phone UI
│   │   │   ├── ScreenMirrorService.kt       # Screen capture service
│   │   │   ├── AutoMirrorService.kt         # Android Auto service
│   │   │   └── AutoMirrorScreen.kt          # Android Auto UI
│   │   ├── res/                             # Resources (layouts, strings)
│   │   └── AndroidManifest.xml              # App configuration
│   └── build.gradle                         # App dependencies
├── build.gradle                             # Project configuration
└── settings.gradle                          # Project settings
```

## Key Components

### 1. MainActivity
- Main interface on your phone
- Start/stop controls
- Permission handling
- Status display

### 2. ScreenMirrorService
- Foreground service for screen capture
- Uses MediaProjection API
- Captures screen frames
- Processes video data

### 3. AutoMirrorService & AutoMirrorScreen
- Android Auto integration
- Car display interface
- Remote control from car

## Permissions

Required permissions:
- `FOREGROUND_SERVICE` - Run capture service in background
- `FOREGROUND_SERVICE_MEDIA_PROJECTION` - Android 14+ requirement
- `RECORD_AUDIO` - Capture app audio
- `POST_NOTIFICATIONS` - Show ongoing notification

## Technical Details

### Screen Capture
- **API**: Android MediaProjection
- **Format**: RGBA_8888
- **Resolution**: Native device resolution
- **Frame Rate**: 30 FPS (adjustable)

### Android Auto Integration
- **Framework**: androidx.car.app
- **Template**: ListTemplate for menu
- **Category**: Navigation (for compatibility)

### Performance
- **CPU Usage**: ~30-40% while capturing
- **RAM Usage**: ~100-150 MB
- **Battery Impact**: High (charging recommended)

## Safety Warning

### ⚠️ CRITICAL SAFETY INFORMATION

**NEVER watch video content while driving!**

- This app is for **PASSENGER USE ONLY** while vehicle is in motion
- Driver must keep eyes on the road at all times
- Only interact with the app when safely parked
- Check your local laws regarding in-vehicle displays
- Many jurisdictions prohibit video displays visible to the driver

**We are not responsible for misuse or accidents. Drive safely!**

## Known Limitations

1. **DRM Content**: Most streaming services (Netflix, Disney+, etc.) block screen capture
2. **Android Auto Restrictions**: Full video streaming not officially supported by Android Auto
3. **Performance**: High battery usage during screen capture
4. **Compatibility**: Some cars may have restrictions on app types
5. **Quality**: Depends on USB connection quality and car display capabilities

## Troubleshooting

### App won't install
- Enable "Install via USB" in Developer Options
- Check USB debugging is enabled
- Try different USB cable

### Screen capture fails
- Grant all permissions
- Restart phone
- Ensure Android 9.0+

### Can't see app in Android Auto
- Enable "Unknown sources" in Android Auto settings
- Reconnect to car
- Check car's Android Auto compatibility

### Black screen with Netflix/Disney+
- This is expected due to DRM
- Try YouTube, Photos, or web browsers instead

For more troubleshooting, see [BEGINNER_INSTALL_GUIDE.md](BEGINNER_INSTALL_GUIDE.md)

## Building from Source

### Prerequisites:
- Android Studio Arctic Fox or later
- Android SDK 34
- Kotlin 1.9.0+
- Gradle 8.2+

### Build Commands:

```bash
# Clean build
./gradlew clean

# Build debug APK
./gradlew assembleDebug

# Build release APK
./gradlew assembleRelease

# Install on connected device
./gradlew installDebug
```

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly on real device
5. Submit a pull request

## Documentation

- 📖 [Complete Beginner's Installation Guide](BEGINNER_INSTALL_GUIDE.md) - Detailed step-by-step for first-timers

## License

This project is provided as-is for educational and personal use.

## Legal Notice

- **Copyright Protection**: Users must comply with copyright laws when streaming content
- **Terms of Service**: Respect streaming platform terms of service
- **Traffic Laws**: Obey all traffic and vehicle safety laws
- **Liability**: We are not responsible for misuse or violations

## Support

Having issues?
1. Check [BEGINNER_INSTALL_GUIDE.md](BEGINNER_INSTALL_GUIDE.md) for detailed help
2. Review troubleshooting sections
3. Open an issue on GitHub with:
   - Device model (Samsung Galaxy S24 Ultra, etc.)
   - Android version
   - Error messages
   - Steps to reproduce

## Acknowledgments

- Built with Android's MediaProjection API
- Uses androidx.car.app for Android Auto integration
- Inspired by the need for better in-car entertainment

---

**Disclaimer**: This is an independent project not affiliated with Samsung, Google, or Android Auto. Android Auto is a trademark of Google LLC.
