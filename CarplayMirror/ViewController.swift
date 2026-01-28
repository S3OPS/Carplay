import UIKit
import ReplayKit

class ViewController: UIViewController {
    
    private let mirrorManager = ScreenMirrorManager.shared
    private var statusLabel: UILabel!
    private var startButton: UIButton!
    private var stopButton: UIButton!
    private var instructionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupNotifications()
    }
    
    private func setupUI() {
        // Title
        let titleLabel = UILabel()
        titleLabel.text = "CarPlay Screen Mirror"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Status label
        statusLabel = UILabel()
        statusLabel.text = "Status: Ready"
        statusLabel.font = UIFont.systemFont(ofSize: 18)
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        // Start button
        startButton = UIButton(type: .system)
        startButton.setTitle("Start Mirroring", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        startButton.backgroundColor = .systemGreen
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 12
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startMirroringTapped), for: .touchUpInside)
        view.addSubview(startButton)
        
        // Stop button
        stopButton = UIButton(type: .system)
        stopButton.setTitle("Stop Mirroring", for: .normal)
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        stopButton.backgroundColor = .systemRed
        stopButton.setTitleColor(.white, for: .normal)
        stopButton.layer.cornerRadius = 12
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.addTarget(self, action: #selector(stopMirroringTapped), for: .touchUpInside)
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        view.addSubview(stopButton)
        
        // Instructions
        instructionsLabel = UILabel()
        instructionsLabel.text = """
        Instructions:
        1. Connect your iPhone to CarPlay
        2. Tap 'Start Mirroring' to begin
        3. Your phone screen will be mirrored to your car display
        4. Open any app (like Netflix) to view it in your car
        5. Tap 'Stop Mirroring' when done
        """
        instructionsLabel.font = UIFont.systemFont(ofSize: 14)
        instructionsLabel.textAlignment = .left
        instructionsLabel.numberOfLines = 0
        instructionsLabel.textColor = .secondaryLabel
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionsLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            startButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            startButton.heightAnchor.constraint(equalToConstant: 56),
            
            stopButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20),
            stopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stopButton.heightAnchor.constraint(equalToConstant: 56),
            
            instructionsLabel.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: 40),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleMirroringStarted),
                                               name: NSNotification.Name("ScreenMirroringStarted"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleMirroringStopped),
                                               name: NSNotification.Name("ScreenMirroringStopped"),
                                               object: nil)
    }
    
    @objc private func startMirroringTapped() {
        mirrorManager.startScreenMirroring { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.statusLabel.text = "Status: Mirroring Active 🟢"
                    self?.startButton.isEnabled = false
                    self?.startButton.alpha = 0.5
                    self?.stopButton.isEnabled = true
                    self?.stopButton.alpha = 1.0
                } else {
                    self?.statusLabel.text = "Status: Failed to start - \(error?.localizedDescription ?? "Unknown error")"
                }
            }
        }
    }
    
    @objc private func stopMirroringTapped() {
        mirrorManager.stopScreenMirroring()
        statusLabel.text = "Status: Stopped"
        startButton.isEnabled = true
        startButton.alpha = 1.0
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
    }
    
    @objc private func handleMirroringStarted() {
        statusLabel.text = "Status: Mirroring Active (via CarPlay) 🟢"
    }
    
    @objc private func handleMirroringStopped() {
        statusLabel.text = "Status: Stopped (via CarPlay)"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
