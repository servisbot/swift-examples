import UIKit
import WebKit
import ServisBOTSDK

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        showMessenger()
    }

    private func showMessenger() {
        let organization = "netscapestg"
        let endpoint = "netscapestg-AskBot"
        let sbRegion = "us-1"
        
        let basicConfig:[String:Any] = [
            "organization": organization,
            "endpoint": endpoint,
            "sbRegion": sbRegion,
        ]
                
        do {
            let sbMessenger = try Messenger(
                config: basicConfig,
                hostNotificationDelegate: hostNotification,
                resetAtStart: false                
            )
            let sbView: WKWebView = try sbMessenger.load()
            sbView.navigationDelegate = self
            self.view.addSubview(sbView)
            setLayoutDetails(webView: sbView)
        } catch {
            print("Messenger failed to load")
        }
    }
    
    func hostNotification(message: String) {
        print("Host Notification \(message)")
    }
    
    func webView(_ webView: WKWebView, didFinish  navigation: WKNavigation!)
    {
        let url = webView.url?.absoluteString
        print("--- Loaded hostpage domain --->\(url!)")
    }
    
    private func setLayoutDetails(webView: WKWebView) {
        // Show web view on screen
        webView.layer.cornerRadius = 20.0
        webView.layer.masksToBounds = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 20.0),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            webView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -20.0),
        ])
    }

}

