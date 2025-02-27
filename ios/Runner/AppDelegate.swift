import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let commentService = CommentService()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        setupMethodChannel(controller: controller)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func setupMethodChannel(controller: FlutterViewController) {
        let commentsChannel = FlutterMethodChannel(
            name: "com.example.verygoodcore.pinapp-challenge/comments",
            binaryMessenger: controller.binaryMessenger
        )
        
        commentsChannel.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            
            if call.method == "getComments" {
                guard let args = call.arguments as? [String: Any],
                      let postId = args["postId"] as? Int else {
                    result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
                    return
                }
                
                self.commentService.getComments(postId: postId) { (jsonString, error) in
                    if let error = error {
                        result(FlutterError(code: "FETCH_ERROR", message: error.localizedDescription, details: nil))
                        return
                    }
                    
                    if let jsonString = jsonString {
                        result(jsonString)
                    } else {
                        result(FlutterError(code: "NO_DATA", message: "No data received", details: nil))
                    }
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}