import SwiftUI
import Presentation

@main
struct BookApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        let rootFlow = Root.Flow.build()
        WindowGroup {
            rootFlow
        }
    }
}
