# Complete Beginner's Guide to Installing Android Auto Mirror on Samsung Galaxy S24 Ultra

This guide will walk you through every step of installing the Android Auto Mirror app on your Samsung Galaxy S24 Ultra, even if you've never developed or installed an Android app before.

## What You'll Need

### Hardware:
- ✅ **Samsung Galaxy S24 Ultra** (your phone)
- ✅ **A Windows PC, Mac, or Linux computer** (for building the app)
- ✅ **USB-C cable** (to connect your phone to your computer)
- ✅ **Car with Android Auto support** (or Android Auto wireless adapter)
- ✅ **Stable internet connection** (for downloading software)

### Time Required:
- **First time setup**: 1-2 hours
- **Building and installing the app**: 15-30 minutes
- **Total**: About 2-3 hours

### Storage Space Needed:
- **On your computer**: About 5-10 GB of free space
- **On your phone**: About 50-100 MB for the app

---

## Part 1: Setting Up Your Computer (One-Time Setup)

### Step 1: Download and Install Android Studio

Android Studio is the official tool for building Android apps. It's free and works on Windows, Mac, and Linux.

#### For Windows:

1. **Open your web browser** (Chrome, Edge, Firefox, etc.)

2. **Go to**: https://developer.android.com/studio

3. **Click the big green "Download Android Studio" button**

4. **Check the agreement box** at the bottom and click "Download Android Studio"

5. **Wait for the download to complete** (it's about 1 GB, so this might take a few minutes)

6. **Find the downloaded file** in your Downloads folder:
   - Look for: `android-studio-[version]-windows.exe`

7. **Double-click the installer** to run it

8. **Click "Next" through the installation wizard**:
   - ✅ Keep all default settings
   - ✅ Click "Next" on each screen
   - ✅ Click "Install" when you reach that button
   - ⏳ Wait for installation (this takes 5-10 minutes)

9. **When complete, click "Finish"**
   - ✅ Make sure "Start Android Studio" is checked

#### For Mac:

1. **Open Safari or Chrome**

2. **Go to**: https://developer.android.com/studio

3. **Click "Download Android Studio"**

4. **Accept the terms** and download

5. **Open the downloaded .dmg file** from your Downloads folder

6. **Drag the Android Studio icon** into the Applications folder

7. **Open Applications folder** and double-click **Android Studio**

8. **If you see a security warning**:
   - Right-click Android Studio → Open
   - Click "Open" on the warning dialog

#### For Linux:

1. **Open Terminal**

2. **Download Android Studio**:
   ```bash
   cd ~/Downloads
   wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/[version]/android-studio-[version]-linux.tar.gz
   ```

3. **Extract the archive**:
   ```bash
   tar -xzf android-studio-*-linux.tar.gz
   ```

4. **Move to /opt**:
   ```bash
   sudo mv android-studio /opt/
   ```

5. **Run Android Studio**:
   ```bash
   /opt/android-studio/bin/studio.sh
   ```

### Step 2: Complete Android Studio First-Time Setup

1. **Android Studio will launch** - you'll see a welcome screen

2. **Click "Next"** on the "Welcome" screen

3. **Choose "Standard" installation type** → Click "Next"

4. **Select your UI theme** (Light or Dark) → Click "Next"

5. **Verify Settings** screen:
   - Just review what it will install
   - Click "Next"

6. **Accept all licenses**:
   - Click each item in the list
   - Click "Accept" for each one
   - Click "Finish"

7. **Wait for downloads** (this can take 20-30 minutes):
   - ⏳ It will download Android SDK
   - ⏳ It will download build tools
   - ☕ Great time for a coffee break!

8. **When complete, click "Finish"**

### Step 3: Install Additional Required Components

1. **In Android Studio, click on "More Actions"** (or "Configure" if you see it)

2. **Select "SDK Manager"**

3. **In the "SDK Platforms" tab**:
   - ✅ Check "Android 14.0 (UpsideDownCake)" (API Level 34)
   - ✅ Check "Android 9.0 (Pie)" (API Level 28)
   - Click "Apply" → "OK"
   - Wait for download

4. **In the "SDK Tools" tab**:
   - ✅ Check "Android SDK Build-Tools"
   - ✅ Check "Android SDK Platform-Tools"
   - ✅ Check "Android SDK Command-line Tools"
   - ✅ Check "Android Emulator"
   - Click "Apply" → "OK"
   - Wait for installation

5. **Click "Finish"** when done

---

## Part 2: Setting Up Your Samsung Galaxy S24 Ultra

### Step 4: Enable Developer Options on Your Phone

1. **Pick up your Samsung Galaxy S24 Ultra**

2. **Open Settings**:
   - Swipe down from top of screen
   - Tap the gear icon ⚙️
   - OR find "Settings" app in your app drawer

3. **Scroll down and tap "About phone"**
   - It's usually near the bottom of Settings

4. **Tap "Software information"**

5. **Find "Build number"**

6. **Tap "Build number" 7 times rapidly**:
   - Tap, tap, tap, tap, tap, tap, tap!
   - After a few taps, you'll see: "You are now X steps away from being a developer"
   - Keep tapping until you see: "Developer mode has been enabled"

7. **Enter your PIN/password** if prompted

8. **You'll see a message**: "Developer options have been turned on"

### Step 5: Enable USB Debugging

1. **Press the back button** to go back to main Settings

2. **Scroll down to "Developer options"**
   - It should now appear in your Settings menu
   - Usually near the bottom

3. **Tap "Developer options"**

4. **Toggle the switch at the top** to turn it ON (it will turn blue/green)

5. **Scroll down and find "USB debugging"**

6. **Toggle "USB debugging" to ON**

7. **A warning will pop up** → Tap "OK"

8. **Also enable these (optional but helpful)**:
   - ✅ "Install via USB" → ON
   - ✅ "USB debugging (Security settings)" → ON (if available)

### Step 6: Connect Your Phone to Your Computer

1. **Get your USB-C cable**
   - Use the one that came with your phone, or a good quality cable

2. **Plug the USB-C end into your S24 Ultra**
   - Into the charging port at the bottom

3. **Plug the USB-A (or USB-C) end into your computer**

4. **On your phone, you'll see a notification**:
   - "Allow USB debugging?"
   - Shows your computer's fingerprint

5. **Check "Always allow from this computer"**

6. **Tap "Allow"**

7. **Your phone may ask** "What do you want to do?"
   - Select "File Transfer" or "MTP"

8. **Verify connection**:
   - Your computer should recognize your phone
   - You might hear a sound or see a notification

---

## Part 3: Getting the App Code

### Step 7: Download the Project

#### Option A: Using Git (Recommended)

1. **Open Terminal/Command Prompt on your computer**:
   - **Windows**: Search for "Command Prompt" or "PowerShell"
   - **Mac**: Press Cmd+Space, type "Terminal", press Enter
   - **Linux**: Press Ctrl+Alt+T

2. **Navigate to where you want to save the project**:
   ```bash
   cd Documents
   ```

3. **Clone the project**:
   ```bash
   git clone https://github.com/S3OPS/Carplay.git
   ```
   
4. **Wait for download** (should be quick, just a few seconds)

5. **Verify it downloaded**:
   ```bash
   cd Carplay
   ls
   ```
   - You should see folders and files

#### Option B: Download as ZIP (Easier for Beginners)

1. **Open your web browser**

2. **Go to**: https://github.com/S3OPS/Carplay

3. **Click the green "Code" button**

4. **Click "Download ZIP"**

5. **Wait for download to complete**

6. **Go to your Downloads folder**

7. **Right-click the downloaded ZIP file**
   - **Windows**: Select "Extract All..."
   - **Mac**: Double-click to extract
   - **Linux**: Right-click → "Extract Here"

8. **Choose where to extract** (e.g., your Documents folder)

9. **Click "Extract"**

---

## Part 4: Opening and Building the Project

### Step 8: Open the Project in Android Studio

1. **Launch Android Studio** if it's not already open
   - **Windows**: Start Menu → Android Studio
   - **Mac**: Applications → Android Studio
   - **Linux**: Run from where you installed it

2. **On the welcome screen, click "Open"**

3. **Navigate to where you downloaded/extracted the project**:
   - Go to `Documents/Carplay/AndroidAutoMirror`
   - OR wherever you saved it

4. **Click on the "AndroidAutoMirror" folder** (very important!)

5. **Click "OK" or "Open"**

6. **Android Studio will start loading the project**:
   - ⏳ This takes 2-5 minutes
   - You'll see "Gradle Build" running at the bottom
   - You might see "Indexing..." at the bottom
   - **Wait patiently!**

7. **If you see any prompts**:
   - "Trust this project?" → Click "Trust Project"
   - "Update Gradle?" → Click "Update"
   - "Install missing components?" → Click "Install"

### Step 9: Wait for Gradle Sync to Complete

1. **Look at the bottom of Android Studio**
   - You'll see a status bar showing progress
   - It says things like "Gradle Build Running..."

2. **Wait for it to finish**:
   - ⏳ First time: 5-15 minutes
   - It's downloading dependencies
   - **Don't close Android Studio!**

3. **When complete, you'll see**:
   - "BUILD SUCCESSFUL" in the bottom panel
   - OR "Gradle sync finished" message

4. **If you see errors**:
   - Go to "File" → "Invalidate Caches / Restart"
   - Click "Invalidate and Restart"
   - Wait for it to reopen and try again

### Step 10: Build the App

1. **Make sure your phone is still connected** to the computer

2. **At the top of Android Studio**, you'll see a toolbar

3. **Find the device selector dropdown**:
   - It looks like a phone icon with text
   - Should say "Samsung SM-S928U" or similar (your S24 Ultra)
   - If it says "No devices", go back to Step 6

4. **Click the green "Play" button** (▶️) next to the device selector
   - OR press Shift+F10 (Windows/Linux)
   - OR press Control+R (Mac)

5. **Android Studio will now**:
   - ✅ Compile the code
   - ✅ Build the APK file
   - ✅ Install it on your phone
   - ⏳ This takes 3-5 minutes the first time

6. **Watch the "Build" panel at the bottom**:
   - You'll see progress messages
   - Wait for "BUILD SUCCESSFUL"

7. **The app will automatically install** on your phone

8. **On your phone**, you'll see:
   - "Installing..." notification
   - Then "App installed"

9. **The app will automatically launch** on your phone!

---

## Part 5: First Time App Setup

### Step 11: Grant Permissions

1. **The app is now running on your S24 Ultra**

2. **You'll see the main screen** with:
   - "Android Auto Mirror" at the top
   - Status: Ready
   - Start Mirroring button (green)
   - Stop Mirroring button (gray, disabled)

3. **Tap "Start Mirroring"**

4. **You'll immediately see a system dialog**:
   - "Allow Android Auto Mirror to record audio?"
   - This is needed to capture sound from apps

5. **Tap "Allow"**

6. **Next, you'll see another dialog**:
   - "Android Auto Mirror will start capturing everything that's displayed on your screen"
   - Shows what will be captured

7. **Tap "Start now"**

8. **The app status changes to**: "Status: Mirroring Active 🟢"

9. **You'll see a persistent notification**:
   - "Screen mirroring active"
   - This stays while mirroring is on

---

## Part 6: Setting Up Android Auto in Your Car

### Step 12: Enable Android Auto on Your Phone

1. **Open Google Play Store** on your phone

2. **Search for "Android Auto"**

3. **Install "Android Auto"** (by Google LLC)
   - It might already be installed on S24 Ultra

4. **Open Android Auto app**

5. **Follow the setup wizard**:
   - Grant location permission → "While using the app"
   - Grant phone permission → "Allow"
   - Grant contacts permission → "Allow"
   - Grant SMS permission → "Allow"

6. **Complete setup**

### Step 13: Connect to Your Car

#### For Wired Android Auto:

1. **Start your car**

2. **Use your USB-C cable**:
   - Plug into your S24 Ultra
   - Plug the other end into your car's USB port
   - Look for ports labeled "Android Auto" or with a phone icon

3. **On your phone's notification**:
   - Tap "Android Auto"
   - OR swipe down and tap the notification

4. **On your car's screen**:
   - Android Auto should launch automatically
   - You'll see the Android Auto interface

5. **If it doesn't start automatically**:
   - Check your car's manual for Android Auto activation
   - Might need to press a button or select from a menu

#### For Wireless Android Auto:

1. **Make sure Bluetooth and Wi-Fi are ON** on your phone

2. **Go to Settings on your phone**

3. **Search for "Android Auto"**

4. **Tap "Android Auto"**

5. **Tap "Previously connected cars"**

6. **Tap "Enable wireless Android Auto"**

7. **In your car**:
   - Go to Bluetooth settings
   - Pair your S24 Ultra
   - Follow prompts on car screen

8. **Once paired, Android Auto connects automatically** when you start your car

---

## Part 7: Using the Screen Mirror App

### Step 14: Start Mirroring to Your Car

1. **Make sure you're connected to Android Auto**
   - See Step 13 above

2. **On your phone, open "Android Auto Mirror" app**

3. **Tap "Start Mirroring"**

4. **Grant permissions** if prompted (see Step 11)

5. **Status changes to "Mirroring Active 🟢"**

6. **On your car's Android Auto display**:
   - Tap the app drawer icon (9 dots)
   - Look for "Android Auto Mirror"
   - Tap it

7. **You'll see a menu**:
   - Start Screen Mirroring
   - Stop Screen Mirroring
   - Status

8. **The status shows "Mirroring Active 🟢"**

### Step 15: Stream Content to Your Car

**⚠️ IMPORTANT SAFETY WARNING:**
- **NEVER watch video while driving!**
- **Only use this feature when parked safely**
- **Passenger use only while vehicle is in motion**
- **Check local laws about in-vehicle displays**

1. **With mirroring active**, open any app on your phone:
   - Netflix
   - YouTube
   - Disney+
   - Photos
   - Web browser
   - Games

2. **Whatever is on your phone screen** will be captured

3. **Play a video** (example with YouTube):
   - Open YouTube app
   - Find a video
   - Tap play
   - The video content is being captured

**🛑 DRM LIMITATION:**
- Many streaming services (Netflix, Disney+, etc.) use **Digital Rights Management (DRM)**
- DRM prevents screen recording for copyright protection
- You may see a **black screen** when playing DRM-protected content
- This is a limitation of Android's security, not the app
- **Will work with**: YouTube (some content), Photos, web browsers, games
- **May not work with**: Netflix, Disney+, HBO Max, Amazon Prime Video

4. **To stop mirroring**:
   - Open Android Auto Mirror app
   - Tap "Stop Mirroring"
   - OR tap "Stop" from the notification

---

## Part 8: Troubleshooting Common Issues

### Problem: "Can't find the app on my phone"

**Solution:**
- Check your app drawer (swipe up from home screen)
- Search for "Android Auto Mirror"
- If not there, go back to Android Studio and click the green play button again

### Problem: "USB debugging not appearing"

**Solution:**
- Make sure you tapped Build Number 7 times (Step 4)
- Restart your phone
- Try Settings → search for "Developer" → Enable Developer Options

### Problem: "Computer doesn't recognize my phone"

**Solution:**
- Try a different USB cable
- Try a different USB port on your computer
- Unlock your phone screen
- Tap "Allow" on the USB debugging dialog
- Restart both phone and computer

### Problem: "Android Studio says 'No devices'"

**Solution:**
1. Check USB cable is connected
2. Check USB debugging is enabled
3. In Android Studio: View → Tool Windows → Device Manager
4. If phone doesn't appear, disconnect and reconnect
5. Make sure you tapped "Allow" on your phone

### Problem: "Build failed in Android Studio"

**Solution:**
1. File → Invalidate Caches / Restart → Invalidate and Restart
2. Wait for it to reopen
3. Build → Clean Project
4. Build → Rebuild Project
5. Try running again

### Problem: "Screen capture permission denied"

**Solution:**
- Some phones block screen capture in certain modes
- Make sure you're not in Secure Folder
- Try restarting the app
- Check Settings → Apps → Android Auto Mirror → Permissions

### Problem: "App crashes when starting mirroring"

**Solution:**
1. Restart your phone
2. Clear app data:
   - Settings → Apps → Android Auto Mirror
   - Tap "Storage"
   - Tap "Clear data"
3. Reinstall the app
4. Make sure Android version is 9.0 or higher

### Problem: "Can't see the app in Android Auto"

**Solution:**
1. Open Android Auto app on phone
2. Tap three-dot menu → Settings
3. Tap "Connected cars"
4. Select your car
5. Make sure "Unknown sources" apps are allowed
6. Disconnect and reconnect to car

### Problem: "Black screen when playing Netflix/Disney+"

**Solution:**
- This is expected behavior due to DRM (see Step 15)
- These services block screen recording for copyright protection
- Try YouTube, Photos app, or web browsers instead
- Not all content can be mirrored due to copyright protections

---

## Part 9: Tips for Best Experience

### Battery Life:
- ✅ Keep phone plugged into car charger while using
- ✅ Screen mirroring uses significant battery
- ✅ Close unnecessary background apps

### Performance:
- ✅ Restart phone before long trips
- ✅ Make sure phone isn't overheating
- ✅ Use high-quality USB cable for wired Android Auto
- ✅ Stay close to car for wireless Android Auto

### Privacy:
- ⚠️ Remember everything on your phone screen is captured
- ⚠️ Notifications will appear on car display
- ⚠️ Enable "Do Not Disturb" mode if needed
- ⚠️ Close sensitive apps before mirroring

### Content:
- ✅ Download videos for offline viewing when possible
- ✅ Create playlists in advance
- ✅ Have content ready before starting drive
- ✅ Use apps that don't have DRM restrictions

---

## Part 10: Uninstalling (If Needed)

### To Remove the App from Your Phone:

1. **On your S24 Ultra**:
   - Long press the app icon
   - Tap "Uninstall"
   - Confirm

2. **OR go to Settings**:
   - Settings → Apps
   - Find "Android Auto Mirror"
   - Tap → Uninstall

### To Remove from Android Studio:

1. **Just delete the project folder**:
   - Go to Documents/Carplay
   - Delete the entire folder

---

## Summary Checklist

Before you start, make sure you have:
- [ ] Computer with 10GB free space
- [ ] Samsung Galaxy S24 Ultra
- [ ] USB-C cable
- [ ] 2-3 hours of time
- [ ] Internet connection
- [ ] Car with Android Auto

Installation steps:
- [ ] Installed Android Studio (30-60 min)
- [ ] Enabled Developer Options on phone (2 min)
- [ ] Enabled USB Debugging (2 min)
- [ ] Downloaded project code (5 min)
- [ ] Opened project in Android Studio (5 min)
- [ ] Built and installed app (10 min)
- [ ] Granted permissions on phone (2 min)
- [ ] Set up Android Auto (10 min)
- [ ] Connected to car (5 min)
- [ ] Tested screen mirroring (5 min)

---

## Getting Help

If you're stuck:

1. **Read the error message carefully** - it usually tells you what's wrong

2. **Search Google** for the specific error message

3. **Check Android Studio's "Logcat"** (bottom of window) for detailed errors

4. **Ask for help on GitHub**: 
   - Go to: https://github.com/S3OPS/Carplay/issues
   - Click "New Issue"
   - Describe your problem with screenshots

5. **Include this information when asking for help**:
   - Your computer operating system (Windows/Mac/Linux)
   - Android Studio version
   - Exact error message
   - What step you're on
   - What you've already tried

---

**Congratulations!** 🎉

If you've made it through all these steps, you now have a working screen mirroring app on your Samsung Galaxy S24 Ultra that can display content on your car's Android Auto system!

Remember: **Always prioritize safety. Never watch video content while driving.**

Enjoy your enhanced in-car experience! 🚗📱✨
