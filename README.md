# CarPlay Screen Mirror

A powerful iOS application that enables screen mirroring from your iPhone to your car's CarPlay display. Stream any content from your phone (including Netflix, YouTube, or any other app) directly to your car's screen.

## Features

- 🚗 **Full CarPlay Integration**: Seamless integration with your car's CarPlay system
- 📱 **Screen Mirroring**: Mirror your entire iPhone screen to your car display
- 🎬 **Stream Any App**: Watch Netflix, YouTube, or any other app on your car screen
- 🎮 **Easy Control**: Simple start/stop controls from both the phone and CarPlay interface
- 🔒 **Privacy & Security**: Uses Apple's ReplayKit framework for secure screen capture
- ⚡ **Real-time Streaming**: Low-latency screen mirroring for smooth playback

## Requirements

- iOS 14.0 or later
- iPhone with CarPlay support
- Car with CarPlay capability (wired or wireless)
- Xcode 14.0 or later (for building)

## Installation

### Option 1: Build from Source

1. Clone the repository:
```bash
git clone https://github.com/S3OPS/Carplay.git
cd Carplay
```

2. Open the project in Xcode:
```bash
open CarplayMirror.xcodeproj
```

3. Configure signing:
   - Select the project in Xcode
   - Go to "Signing & Capabilities"
   - Select your development team
   - Xcode will automatically configure provisioning profiles

4. Build and run:
   - Select your iPhone as the target device
   - Press `Cmd + R` to build and run

### Option 2: TestFlight (Coming Soon)

A TestFlight version will be available for easy installation without building from source.

## Usage

### Initial Setup

1. **Connect to CarPlay**:
   - Connect your iPhone to your car's CarPlay system (via USB or wireless)
   - The CarPlay interface should appear on your car's display

2. **Launch the App**:
   - Open the CarPlay Mirror app on your iPhone
   - You'll see the main control screen

### Starting Screen Mirroring

**From iPhone:**
1. Tap the "Start Mirroring" button
2. Grant screen recording permissions when prompted
3. The status will change to "Mirroring Active 🟢"

**From CarPlay:**
1. Find the "CarPlay Mirror" app on your car display
2. Tap "Start Screen Mirroring"
3. The car display will show "Mirroring Active"

### Viewing Content

Once mirroring is active:
1. Open any app on your iPhone (Netflix, YouTube, etc.)
2. The content will automatically appear on your car's display
3. Control playback from your phone as normal
4. Audio will play through your car's speakers

### Stopping Mirroring

- Tap "Stop Mirroring" from either the iPhone app or CarPlay interface
- Screen mirroring will cease immediately

## Technical Details

### Architecture

The app consists of several key components:

1. **AppDelegate**: Manages app lifecycle and scene configuration
2. **ViewController**: Main iPhone interface for controlling mirroring
3. **CarPlaySceneDelegate**: Handles CarPlay interface and interaction
4. **ScreenMirrorManager**: Core mirroring logic using ReplayKit

### Screen Capture Technology

The app uses Apple's **ReplayKit** framework (`RPScreenRecorder`) to capture screen content:
- Captures video frames in real-time
- Low system overhead
- Respects system privacy settings
- Automatically handles app permissions

### CarPlay Integration

Implements Apple's **CarPlay Framework** (`CPTemplateApplicationSceneDelegate`):
- Uses `CPListTemplate` for the interface
- Supports both wired and wireless CarPlay
- Provides real-time status updates
- Custom video display window

### Privacy & Permissions

Required permissions (automatically requested):
- **Screen Recording**: To capture your phone's display
- **Audio** (optional): To capture app audio for streaming

## Configuration

### Info.plist

The app requires specific configurations in `Info.plist`:

```xml
<key>UIApplicationSceneManifest</key>
<dict>
    <key>UISceneConfigurations</key>
    <dict>
        <key>CPTemplateApplicationSceneSessionRoleApplication</key>
        <array>
            <dict>
                <key>UISceneConfigurationName</key>
                <string>CarPlay Configuration</string>
                <key>UISceneDelegateClassName</key>
                <string>CarPlaySceneDelegate</string>
            </dict>
        </array>
    </dict>
</dict>
```

### Entitlements

Required entitlements in `CarplayMirror.entitlements`:

```xml
<key>com.apple.developer.carplay-audio</key>
<true/>
<key>com.apple.developer.playable-content</key>
<true/>
```

## Troubleshooting

### Screen Mirroring Not Starting

1. **Check Permissions**: Go to Settings > Privacy > Screen Recording and ensure the app is enabled
2. **Restart the App**: Force quit and relaunch the app
3. **Update iOS**: Ensure you're running iOS 14.0 or later

### CarPlay Not Showing the App

1. **Verify CarPlay Settings**: Settings > General > CarPlay > Select your car
2. **Reconnect to CarPlay**: Unplug and replug your iPhone
3. **Check Entitlements**: Ensure the app is properly signed with CarPlay entitlements

### No Video on Car Display

1. **Restart Mirroring**: Stop and start the mirroring again
2. **Check Cable**: If using wired CarPlay, try a different cable
3. **Update Car Software**: Some cars may need firmware updates

## Known Limitations

- **DRM Content**: Some streaming services may block screen recording due to DRM protection
- **Performance**: Screen mirroring quality depends on your car's display capabilities
- **Battery Usage**: Extended screen mirroring may drain your battery faster
- **iOS Restrictions**: Some system screens cannot be captured (e.g., lock screen)

## Future Enhancements

- [ ] Resolution optimization for different car displays
- [ ] Audio synchronization improvements
- [ ] Support for landscape/portrait orientation switching
- [ ] Recording saved sessions
- [ ] Multiple display profiles for different cars
- [ ] Widget support for quick access

## Development

### Project Structure

```
CarplayMirror/
├── AppDelegate.swift              # App lifecycle management
├── CarPlaySceneDelegate.swift     # CarPlay interface
├── ViewController.swift           # Main phone UI
├── ScreenMirrorManager.swift      # Screen capture logic
├── Info.plist                     # App configuration
├── CarplayMirror.entitlements     # Required entitlements
├── Main.storyboard                # Phone UI layout
├── LaunchScreen.storyboard        # Launch screen
└── Assets.xcassets/               # App assets
```

### Building

```bash
# Clean build
xcodebuild clean -project CarplayMirror.xcodeproj

# Build for device
xcodebuild -project CarplayMirror.xcodeproj \
           -scheme CarplayMirror \
           -configuration Release \
           -destination 'generic/platform=iOS'
```

### Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is provided as-is for educational and personal use.

## Legal Notice

This app is designed for personal use. Users are responsible for ensuring they comply with:
- Copyright laws when streaming content
- Terms of service for streaming platforms
- Local traffic laws (never watch video while driving)

**⚠️ SAFETY WARNING**: Never watch video content while driving. This app is intended for passenger use only.

## Support

For issues, questions, or feature requests, please open an issue on GitHub.

## Acknowledgments

- Built with Apple's CarPlay and ReplayKit frameworks
- Inspired by the need for better in-car entertainment options
- Thanks to the iOS development community

---

**Disclaimer**: This is an independent project and is not affiliated with, endorsed by, or associated with Apple Inc. CarPlay is a trademark of Apple Inc.
