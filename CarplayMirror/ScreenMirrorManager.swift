import Foundation
import ReplayKit
import AVFoundation

class ScreenMirrorManager: NSObject {
    
    static let shared = ScreenMirrorManager()
    
    private var screenRecorder: RPScreenRecorder?
    private var isRecording = false
    private var videoOutputURL: URL?
    
    private override init() {
        super.init()
        screenRecorder = RPScreenRecorder.shared()
        setupNotifications()
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleStartMirroringNotification),
                                               name: NSNotification.Name("StartScreenMirroring"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleStopMirroringNotification),
                                               name: NSNotification.Name("StopScreenMirroring"),
                                               object: nil)
    }
    
    @objc private func handleStartMirroringNotification() {
        startScreenMirroring { success, error in
            if success {
                NotificationCenter.default.post(name: NSNotification.Name("ScreenMirroringStarted"), object: nil)
            }
        }
    }
    
    @objc private func handleStopMirroringNotification() {
        stopScreenMirroring()
        NotificationCenter.default.post(name: NSNotification.Name("ScreenMirroringStopped"), object: nil)
    }
    
    func startScreenMirroring(completion: @escaping (Bool, Error?) -> Void) {
        guard let screenRecorder = screenRecorder else {
            completion(false, NSError(domain: "ScreenMirrorManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Screen recorder not available"]))
            return
        }
        
        guard screenRecorder.isAvailable else {
            completion(false, NSError(domain: "ScreenMirrorManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "Screen recording not available on this device"]))
            return
        }
        
        if isRecording {
            completion(true, nil)
            return
        }
        
        // Configure recording parameters
        screenRecorder.isMicrophoneEnabled = false
        screenRecorder.isCameraEnabled = false
        
        // Start capturing screen content
        screenRecorder.startCapture(handler: { [weak self] (sampleBuffer, bufferType, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error capturing screen: \(error.localizedDescription)")
                return
            }
            
            // Process the captured frame
            self.processCapturedFrame(sampleBuffer, type: bufferType)
            
        }) { [weak self] error in
            if let error = error {
                print("Failed to start screen capture: \(error.localizedDescription)")
                self?.isRecording = false
                completion(false, error)
            } else {
                print("Screen capture started successfully")
                self?.isRecording = true
                completion(true, nil)
            }
        }
    }
    
    func stopScreenMirroring() {
        guard let screenRecorder = screenRecorder, isRecording else {
            return
        }
        
        screenRecorder.stopCapture { [weak self] error in
            if let error = error {
                print("Error stopping screen capture: \(error.localizedDescription)")
            } else {
                print("Screen capture stopped successfully")
            }
            self?.isRecording = false
        }
    }
    
    private func processCapturedFrame(_ sampleBuffer: CMSampleBuffer, type: RPSampleBufferType) {
        // This is where you would process the captured frames
        // For a real implementation, you would:
        // 1. Encode the frames to a video format
        // 2. Stream them to the CarPlay display
        // 3. Handle audio synchronization if needed
        
        switch type {
        case .video:
            // Handle video frame
            // In a production app, you would encode and stream this to CarPlay
            break
        case .audioApp:
            // Handle app audio
            break
        case .audioMic:
            // Handle microphone audio (if enabled)
            break
        @unknown default:
            break
        }
    }
    
    var isMirroring: Bool {
        return isRecording
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
