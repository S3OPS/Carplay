# CarPlay Screen Mirror - Detailed Setup Guide

This guide will walk you through the complete setup process for the CarPlay Screen Mirror application.

## Prerequisites

Before you begin, ensure you have:

1. **macOS Computer** (for building iOS apps)
2. **Xcode 14.0 or later** - [Download from Mac App Store](https://apps.apple.com/us/app/xcode/id497799835)
3. **Apple Developer Account** - Free or paid account
4. **iPhone running iOS 14.0+**
5. **Car with CarPlay support**

## Step 1: Install Xcode

1. Open the Mac App Store
2. Search for "Xcode"
3. Click "Get" or "Install"
4. Wait for the download and installation to complete (this may take a while)
5. Open Xcode and accept the license agreement
6. Install additional components when prompted

## Step 2: Clone or Download the Project

### Using Git:
```bash
git clone https://github.com/S3OPS/Carplay.git
cd Carplay
```

### Or download ZIP:
1. Go to the GitHub repository
2. Click "Code" → "Download ZIP"
3. Extract the ZIP file
4. Navigate to the extracted folder

## Step 3: Open the Project in Xcode

```bash
open CarplayMirror.xcodeproj
```

Or:
1. Launch Xcode
2. Click "Open a project or file"
3. Navigate to the `CarplayMirror.xcodeproj` file
4. Click "Open"

## Step 4: Configure Code Signing

### For Free Apple Developer Account:

1. In Xcode, select the project in the navigator (blue icon at the top)
2. Select the "CarplayMirror" target
3. Go to the "Signing & Capabilities" tab
4. Under "Team", select your Apple ID
   - If you don't see your Apple ID, click "Add Account" and sign in
5. Change the "Bundle Identifier" to something unique:
   - Example: `com.yourname.carplaymirror`
6. Xcode will automatically manage the provisioning profile

### For Paid Apple Developer Account:

1. Follow steps 1-3 above
2. Select your team from the dropdown
3. Keep or modify the Bundle Identifier as needed
4. Ensure "Automatically manage signing" is checked

### Adding CarPlay Entitlements (Paid Account Only):

⚠️ **Note**: CarPlay entitlements require a paid Apple Developer account and special approval from Apple.

1. Go to [developer.apple.com](https://developer.apple.com)
2. Navigate to "Certificates, Identifiers & Profiles"
3. Request CarPlay entitlement for your app
4. Wait for Apple's approval (can take several days)

For development/testing without CarPlay entitlements:
- The app will still work on your phone
- CarPlay features will only work in the simulator or with proper entitlements

## Step 5: Connect Your iPhone

1. Connect your iPhone to your Mac using a USB cable
2. Unlock your iPhone
3. If prompted, trust the computer on your iPhone
4. In Xcode, select your iPhone from the device dropdown (top bar, next to the play button)

### Enable Developer Mode on iPhone:

For iOS 16+:
1. Go to Settings → Privacy & Security → Developer Mode
2. Toggle "Developer Mode" on
3. Restart your iPhone when prompted
4. Confirm activation after restart

## Step 6: Build and Run

1. Click the "Play" button (▶) in Xcode, or press `Cmd + R`
2. Wait for the build to complete
3. On your iPhone, you may see "Untrusted Developer" error
4. Go to Settings → General → VPN & Device Management
5. Tap your Apple ID and trust it
6. Return to the app and it should launch

## Step 7: Set Up CarPlay Connection

### For Wired CarPlay:

1. Use a compatible USB cable (Apple Lightning cable recommended)
2. Connect your iPhone to your car's USB port
3. CarPlay should launch automatically on your car's display
4. If not, check your car's manual for CarPlay activation

### For Wireless CarPlay:

1. Ensure Bluetooth and Wi-Fi are enabled on your iPhone
2. Pair your iPhone with your car via Bluetooth
3. Follow your car's instructions to enable wireless CarPlay
4. CarPlay should connect automatically when you start your car

## Step 8: Grant Permissions

When you first launch the app and start mirroring:

1. **Screen Recording Permission**:
   - The app will request screen recording access
   - Tap "OK" to allow
   - If denied, go to Settings → Privacy → Screen Recording → CarPlay Mirror → Enable

2. **Microphone Permission** (optional):
   - May be requested for audio capture
   - Grant if you want audio from apps to stream

## Step 9: Test the App

### On iPhone:

1. Launch the CarPlay Mirror app
2. You should see the main interface with:
   - "Start Mirroring" button
   - "Stop Mirroring" button (disabled)
   - Status display
   - Instructions

### On CarPlay:

1. Look for "CarPlay Mirror" on your car's display
2. Tap to open
3. You should see:
   - "Start Screen Mirroring" option
   - "Stop Screen Mirroring" option

### Start Mirroring:

1. Tap "Start Mirroring" from either interface
2. Status should change to "Mirroring Active 🟢"
3. Open any app on your iPhone (e.g., Photos, Safari)
4. The content should appear on your car's display

## Troubleshooting

### "Cannot Run on Device" Error

**Problem**: Xcode cannot install the app on your device.

**Solutions**:
- Ensure your iPhone is unlocked
- Check that you trusted the computer on your iPhone
- Try unplugging and replugging the USB cable
- Restart Xcode
- Clean the build: Product → Clean Build Folder (Cmd + Shift + K)

### "Code Signing Error"

**Problem**: Code signing issues prevent building.

**Solutions**:
- Make sure you're signed in to your Apple ID in Xcode
- Change the Bundle Identifier to something unique
- Go to Xcode → Preferences → Accounts → Download Manual Profiles
- Try "Automatically manage signing"

### "Screen Recording Not Available"

**Problem**: Screen recording permission denied.

**Solutions**:
- Go to Settings → Privacy & Security → Screen Recording
- Find "CarPlay Mirror" and enable it
- Restart the app

### CarPlay Not Showing the App

**Problem**: App doesn't appear in CarPlay.

**Solutions**:
- Check that your Apple ID has CarPlay entitlements
- Verify Info.plist has CarPlay scene configuration
- Reconnect to CarPlay
- Restart both your iPhone and car's infotainment system

### Build Errors

**Problem**: Compilation errors in Xcode.

**Solutions**:
- Make sure you're using Xcode 14.0 or later
- Check that deployment target is iOS 14.0 or later
- Clean build folder: Product → Clean Build Folder
- Delete derived data: Xcode → Preferences → Locations → Click arrow next to Derived Data → Delete folder
- Restart Xcode

## Testing Without a Car

You can test the app's functionality without a physical CarPlay connection:

### Using CarPlay Simulator:

1. Run the app in the iOS Simulator
2. In the Simulator menu: I/O → External Displays → CarPlay
3. A CarPlay window will appear
4. Test the app's CarPlay interface

### Limitations:
- Screen mirroring won't work in simulator
- Audio routing will use Mac speakers
- Full testing requires physical device and CarPlay connection

## Performance Tips

1. **Use a Good Cable**: For wired CarPlay, use an Apple-certified cable
2. **Close Background Apps**: Free up iPhone resources
3. **Keep iOS Updated**: Latest iOS version has performance improvements
4. **Stable Connection**: Ensure stable Wi-Fi for wireless CarPlay
5. **Disable Unnecessary Features**: Turn off features you don't need to save battery

## Safety Reminders

⚠️ **IMPORTANT SAFETY INFORMATION**:

- **Never watch video while driving**
- This app is for **passenger use only**
- Driver should focus on the road
- Check local laws regarding in-vehicle displays
- Use responsibly and safely

## Getting Help

If you encounter issues:

1. Check this setup guide thoroughly
2. Review the main README.md file
3. Open an issue on GitHub with:
   - Your iOS version
   - Xcode version
   - Error messages or screenshots
   - Steps to reproduce the problem

## Next Steps

Once everything is working:

1. Try different apps (YouTube, Photos, etc.)
2. Test both wired and wireless CarPlay
3. Experiment with the interface
4. Provide feedback for improvements

## Advanced Configuration

### Custom Bundle Identifier

To use your own bundle identifier:

1. In Xcode, select the project
2. Select the target
3. General tab → Identity → Bundle Identifier
4. Change to your preferred identifier (e.g., com.yourcompany.carplaymirror)

### Release Build

To create a release build:

1. Product → Scheme → Edit Scheme
2. Run → Build Configuration → Release
3. Build and run

### Distribution

For distributing to others:

1. Paid Apple Developer account required
2. Create App Store Connect listing
3. Configure TestFlight
4. Submit for review

## Resources

- [Apple CarPlay Documentation](https://developer.apple.com/carplay/)
- [ReplayKit Documentation](https://developer.apple.com/documentation/replaykit)
- [Xcode Help](https://developer.apple.com/xcode/)
- [iOS Developer Documentation](https://developer.apple.com/ios/)

---

Happy coding! 🚗📱
