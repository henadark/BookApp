import SwiftUI
import Presentation
import UIStyleKit

@main
struct BookApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    init() {
        CustomFonts.registerFonts()
    }

    var body: some Scene {
        let rootFlow = Root.Flow.build()
        WindowGroup {
            rootFlow
        }
    }
}
