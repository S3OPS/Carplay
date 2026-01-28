import CarPlay
import UIKit

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    
    var interfaceController: CPInterfaceController?
    var carPlayWindow: CPWindow?
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                   didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController
        self.carPlayWindow = templateApplicationScene.carWindow
        
        // Set up the CarPlay interface
        setupCarPlayInterface()
    }
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                   didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
        self.carPlayWindow = nil
    }
    
    private func setupCarPlayInterface() {
        guard let interfaceController = interfaceController else { return }
        
        // Create the main list template
        let startMirroringItem = CPListItem(text: "Start Screen Mirroring", detailText: "Mirror your phone screen to CarPlay")
        startMirroringItem.handler = { [weak self] item, completion in
            self?.startMirroring()
            completion()
        }
        
        let stopMirroringItem = CPListItem(text: "Stop Screen Mirroring", detailText: "Stop mirroring to CarPlay")
        stopMirroringItem.handler = { [weak self] item, completion in
            self?.stopMirroring()
            completion()
        }
        
        let section = CPListSection(items: [startMirroringItem, stopMirroringItem])
        let listTemplate = CPListTemplate(title: "CarPlay Mirror", sections: [section])
        
        // Set the root template
        interfaceController.setRootTemplate(listTemplate, animated: true)
        
        // Create a custom view for video display
        setupVideoDisplayWindow()
    }
    
    private func setupVideoDisplayWindow() {
        guard let carPlayWindow = carPlayWindow else { return }
        
        // Create a view controller to display the mirrored content
        let mirrorViewController = UIViewController()
        mirrorViewController.view.backgroundColor = .black
        
        // Add a label to show the mirroring status
        let statusLabel = UILabel()
        statusLabel.text = "Ready to Mirror"
        statusLabel.textColor = .white
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        mirrorViewController.view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: mirrorViewController.view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: mirrorViewController.view.centerYAnchor)
        ])
        
        carPlayWindow.rootViewController = mirrorViewController
        carPlayWindow.makeKeyAndVisible()
    }
    
    private func startMirroring() {
        // Notify the screen mirror manager to start
        NotificationCenter.default.post(name: NSNotification.Name("StartScreenMirroring"), object: nil)
        
        // Update the CarPlay display
        if let carPlayWindow = carPlayWindow,
           let label = carPlayWindow.rootViewController?.view.subviews.first as? UILabel {
            label.text = "Mirroring Active"
            label.textColor = .green
        }
    }
    
    private func stopMirroring() {
        // Notify the screen mirror manager to stop
        NotificationCenter.default.post(name: NSNotification.Name("StopScreenMirroring"), object: nil)
        
        // Update the CarPlay display
        if let carPlayWindow = carPlayWindow,
           let label = carPlayWindow.rootViewController?.view.subviews.first as? UILabel {
            label.text = "Mirroring Stopped"
            label.textColor = .white
        }
    }
}
