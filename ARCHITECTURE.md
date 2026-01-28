# CarPlay Screen Mirror - Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         iPhone Device                            │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                    CarPlay Mirror App                      │  │
│  │                                                            │  │
│  │  ┌──────────────┐    ┌─────────────────────────────┐     │  │
│  │  │              │    │                             │     │  │
│  │  │  AppDelegate │───▶│   ViewController            │     │  │
│  │  │              │    │  (Main Phone UI)            │     │  │
│  │  └──────┬───────┘    │  - Start/Stop Buttons       │     │  │
│  │         │            │  - Status Display           │     │  │
│  │         │            └─────────────┬───────────────┘     │  │
│  │         │                          │                     │  │
│  │         │                          │ Notifications       │  │
│  │         │                          │                     │  │
│  │  ┌──────▼──────────┐               │                     │  │
│  │  │                 │               │                     │  │
│  │  │  Scene Manager  │◀──────────────┘                     │  │
│  │  │                 │                                     │  │
│  │  └────┬───────┬────┘                                     │  │
│  │       │       │                                          │  │
│  │       │       │                                          │  │
│  │ ┌─────▼──┐  ┌─▼────────────────────────────────────┐    │  │
│  │ │        │  │                                       │    │  │
│  │ │ Phone  │  │   CarPlaySceneDelegate               │    │  │
│  │ │ Scene  │  │   - CPInterfaceController            │    │  │
│  │ │        │  │   - Menu Templates                   │    │  │
│  │ └────────┘  │   - Video Display Window             │    │  │
│  │             └───────────────┬──────────────────────┘    │  │
│  │                             │                           │  │
│  │                             │ Control Commands          │  │
│  │             ┌───────────────▼──────────────────────┐    │  │
│  │             │                                       │    │  │
│  │             │   ScreenMirrorManager                 │    │  │
│  │             │   ┌─────────────────────────────┐    │    │  │
│  │             │   │   RPScreenRecorder          │    │    │  │
│  │             │   │   (ReplayKit Framework)     │    │    │  │
│  │             │   │                             │    │    │  │
│  │             │   │   - Capture Video Frames    │    │    │  │
│  │             │   │   - Capture Audio           │    │    │  │
│  │             │   │   - Process Buffers         │    │    │  │
│  │             │   └─────────────────────────────┘    │    │  │
│  │             └───────────────┬──────────────────────┘    │  │
│  │                             │                           │  │
│  └─────────────────────────────┼───────────────────────────┘  │
│                                │                               │
│                       Screen Content Stream                    │
│                                │                               │
└────────────────────────────────┼───────────────────────────────┘
                                 │
                                 │ USB/Wireless
                                 │
┌────────────────────────────────▼───────────────────────────────┐
│                        Car Infotainment System                  │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐   │
│  │              CarPlay Display Interface                  │   │
│  │                                                         │   │
│  │  ┌────────────────┐      ┌─────────────────────────┐  │   │
│  │  │                │      │                         │  │   │
│  │  │  Menu Screen   │      │   Video Display         │  │   │
│  │  │                │      │   - Shows iPhone Screen │  │   │
│  │  │  • Start       │      │   - Real-time Updates   │  │   │
│  │  │  • Stop        │      │   - Full Resolution     │  │   │
│  │  │  • Status      │      │                         │  │   │
│  │  │                │      │                         │  │   │
│  │  └────────────────┘      └─────────────────────────┘  │   │
│  │                                                         │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐   │
│  │              Audio Output System                        │   │
│  │              - Speakers                                 │   │
│  │              - Volume Control                           │   │
│  └────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## Component Details

### 1. AppDelegate
**Purpose**: Application lifecycle management

**Responsibilities**:
- Configure app on launch
- Manage scene sessions
- Route to appropriate scene delegate (Phone or CarPlay)

**Key Methods**:
```swift
application(_:configurationForConnecting:options:)
  └─> Determines if scene is Phone or CarPlay
  └─> Returns appropriate configuration
```

### 2. ViewController (Main Phone UI)
**Purpose**: User interface for iPhone screen

**Responsibilities**:
- Display start/stop buttons
- Show mirroring status
- Handle user input
- Display instructions

**Communication**:
- Sends commands to ScreenMirrorManager
- Receives notifications for status updates
- Updates UI based on state changes

**Key Features**:
```
┌─────────────────────────────┐
│   CarPlay Screen Mirror     │
├─────────────────────────────┤
│  Status: Ready              │
│                             │
│  ┌───────────────────────┐  │
│  │  Start Mirroring     │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │  Stop Mirroring      │  │
│  └───────────────────────┘  │
│                             │
│  Instructions:              │
│  1. Connect to CarPlay      │
│  2. Tap Start Mirroring     │
│  3. Open any app            │
└─────────────────────────────┘
```

### 3. CarPlaySceneDelegate
**Purpose**: Manage CarPlay interface and display

**Responsibilities**:
- Create and manage CarPlay templates
- Handle CarPlay connection/disconnection
- Display video window on car screen
- Process user input from car display

**Templates Used**:
- `CPListTemplate`: Menu with start/stop options
- Custom UIViewController: Video display area

**Flow**:
```
CarPlay Connected
    ↓
Setup Interface
    ↓
Create Menu Template
    ↓
Setup Video Display Window
    ↓
Wait for User Input
    ↓
Send Notifications to ScreenMirrorManager
```

### 4. ScreenMirrorManager
**Purpose**: Core screen capture and streaming logic

**Responsibilities**:
- Initialize ReplayKit screen recorder
- Start/stop screen capture
- Process captured video frames
- Handle audio capture
- Manage capture state

**Key Properties**:
```swift
- screenRecorder: RPScreenRecorder
- isRecording: Bool
- videoOutputURL: URL?
```

**Capture Flow**:
```
Start Request
    ↓
Check Availability
    ↓
Configure Recorder
    ↓
Start Capture
    ↓
Receive Sample Buffers
    ↓
Process Frames
    ↓
Stream to CarPlay
```

### 5. ReplayKit Framework (RPScreenRecorder)
**Purpose**: Apple's built-in screen recording API

**Capabilities**:
- Capture video frames at device resolution
- Capture app audio
- Capture microphone audio (optional)
- Low-latency capture
- System-level permissions handling

**Buffer Types**:
- `.video`: Video frames (CMSampleBuffer)
- `.audioApp`: App audio
- `.audioMic`: Microphone audio (if enabled)

## Communication Flow

### Starting Mirroring from Phone

```
User Taps "Start"
    ↓
ViewController.startMirroringTapped()
    ↓
ScreenMirrorManager.startScreenMirroring()
    ↓
RPScreenRecorder.startCapture()
    ↓
Success Callback
    ↓
Post Notification: "ScreenMirroringStarted"
    ↓
ViewController receives notification
    ↓
Update UI: "Status: Mirroring Active 🟢"
```

### Starting Mirroring from CarPlay

```
User Taps "Start Screen Mirroring" in Car
    ↓
CarPlaySceneDelegate.startMirroring()
    ↓
Post Notification: "StartScreenMirroring"
    ↓
ScreenMirrorManager receives notification
    ↓
ScreenMirrorManager.startScreenMirroring()
    ↓
RPScreenRecorder.startCapture()
    ↓
Success Callback
    ↓
Post Notification: "ScreenMirroringStarted"
    ↓
Both interfaces receive notification
    ↓
Update displays: "Mirroring Active"
```

### Frame Processing Pipeline

```
Screen Content
    ↓
iOS System Compositor
    ↓
ReplayKit (RPScreenRecorder)
    ↓
CMSampleBuffer
    ↓
ScreenMirrorManager.processCapturedFrame()
    ↓
[Future: Encode to H.264]
    ↓
[Future: Stream via Network/USB]
    ↓
CarPlay Display System
    ↓
Car Screen Output
```

## Data Flow

### Notifications System

The app uses NotificationCenter for component communication:

```
Notification Name              | Sender                  | Receiver
------------------------------|-------------------------|------------------------
"StartScreenMirroring"        | CarPlaySceneDelegate   | ScreenMirrorManager
"StopScreenMirroring"         | CarPlaySceneDelegate   | ScreenMirrorManager
"ScreenMirroringStarted"      | ScreenMirrorManager    | All UI Components
"ScreenMirroringStopped"      | ScreenMirrorManager    | All UI Components
```

### State Management

```
App State Machine:

    ┌─────────┐
    │  Ready  │
    └────┬────┘
         │
    Start Command
         │
         ▼
┌───────────────┐
│  Starting...  │
└───────┬───────┘
        │
   RPScreenRecorder
   .startCapture()
        │
        ▼
  ┌──────────┐
  │ Active   │◀──── Capturing frames
  │ Mirroring│      Processing buffers
  └─────┬────┘      Streaming content
        │
   Stop Command
        │
        ▼
  ┌──────────┐
  │ Stopping │
  └─────┬────┘
        │
   RPScreenRecorder
   .stopCapture()
        │
        ▼
    ┌─────────┐
    │ Stopped │
    └────┬────┘
         │
         └──────▶ Back to Ready
```

## Technical Stack

### Frameworks Used

1. **UIKit**: Core UI framework
   - UIViewController for screens
   - UIButton, UILabel for interface elements
   - UIWindow for display management

2. **CarPlay**: Car integration
   - CPTemplateApplicationSceneDelegate
   - CPInterfaceController
   - CPListTemplate, CPListItem
   - CPWindow for car display

3. **ReplayKit**: Screen capture
   - RPScreenRecorder for capture
   - CMSampleBuffer for video data
   - AVFoundation for media handling

4. **Foundation**: Core functionality
   - NotificationCenter for messaging
   - URL for file management
   - Error handling

### System Requirements

- **iOS**: 14.0 or later
- **CarPlay**: Compatible car or simulator
- **Permissions**: Screen Recording, Audio (optional)
- **Hardware**: iPhone with A9 chip or newer recommended

## Security & Privacy

### Permissions Flow

```
App Launch
    ↓
User Taps "Start Mirroring"
    ↓
System Checks Screen Recording Permission
    ↓
┌─────────┴─────────┐
│                   │
Permission Granted  Permission Denied
│                   │
│                   └──> Show Error
│                        Prompt User to Settings
│
└──> Start Capture
     Begin Mirroring
```

### Privacy Protections

1. **User Consent**: Explicit permission required
2. **Visual Indicator**: System shows recording indicator
3. **Secure Capture**: ReplayKit handles security
4. **Local Processing**: No data sent to servers
5. **User Control**: Easy start/stop mechanism

## Future Enhancements

### Phase 2 Improvements

1. **Enhanced Streaming**:
   - H.264 encoding for compression
   - Adaptive bitrate based on connection
   - Buffer management for smooth playback

2. **Quality Settings**:
   - Resolution options (1080p, 720p, 480p)
   - Frame rate control (60fps, 30fps, 15fps)
   - Bitrate adjustment

3. **Advanced Features**:
   - Multiple car profiles
   - Orientation handling
   - Picture-in-picture support
   - Recording to file option

### Architecture Evolution

```
Current: Direct Capture → Display
             ↓
Future: Capture → Encode → Buffer → Stream → Decode → Display
                     ↓        ↓        ↓
                  Quality   Network  Adaptive
                  Control   Monitor  Bitrate
```

## Performance Considerations

### Optimization Strategies

1. **Frame Rate Management**:
   - Capture at 30fps (default)
   - Option for 60fps on capable devices
   - Adaptive frame skip on low battery

2. **Memory Management**:
   - Release buffers immediately after processing
   - Pool reusable objects
   - Monitor memory pressure

3. **Battery Optimization**:
   - Reduce quality on low battery
   - Background processing limits
   - Efficient codec usage

### Resource Usage

```
Component              | CPU Usage | Memory  | Battery Impact
-----------------------|-----------|---------|---------------
Screen Capture         | Medium    | Low     | Medium
Video Processing       | Medium    | Medium  | Medium
UI Updates            | Low       | Low     | Low
CarPlay Communication  | Low       | Low     | Low
Total (Mirroring)      | ~30-40%   | ~100MB  | High
```

## Error Handling

### Error Scenarios

1. **Screen Recording Unavailable**:
   ```
   Check: RPScreenRecorder.isAvailable
   Action: Show alert with explanation
   Fallback: None (hardware limitation)
   ```

2. **Permission Denied**:
   ```
   Check: Capture start callback
   Action: Guide user to Settings
   Fallback: Retry after permission granted
   ```

3. **CarPlay Disconnected**:
   ```
   Event: didDisconnect callback
   Action: Stop mirroring, clean up resources
   Fallback: Resume when reconnected
   ```

4. **Capture Failure**:
   ```
   Check: Error in capture handler
   Action: Log error, notify user
   Fallback: Automatic retry once
   ```

## Testing Strategy

### Unit Tests
- ScreenMirrorManager state transitions
- Notification handling
- Error scenarios

### Integration Tests
- Phone UI → Manager communication
- CarPlay → Manager communication
- End-to-end mirroring flow

### Manual Tests
- Physical device testing
- Real CarPlay connection
- Various apps (Netflix, YouTube, etc.)
- Different cars/head units

---

This architecture provides a solid foundation for screen mirroring to CarPlay with room for enhancement and optimization.
