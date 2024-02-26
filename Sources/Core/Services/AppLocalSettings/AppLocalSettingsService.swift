import Foundation

public final class AppLocalSettingsService {

    // MARK: Stored Properties

    private let viewSettings: ViewSettings

    // MARK: Init

    public init(viewSettings: ViewSettings = ViewSettings()) {
        self.viewSettings = viewSettings
    }
}

extension AppLocalSettingsService: AppLocalSettingsServiceProtocol {

    // View
    public var timeIntervalCarousel: TimeInterval { viewSettings.timeIntervalCarousel }

}
