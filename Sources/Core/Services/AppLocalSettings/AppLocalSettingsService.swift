import Foundation

public final class AppLocalSettingsService {

    // MARK: Stored Properties

    private let projectSettings: ProjectSettings

    // MARK: Init

    public init(projectSettings: ProjectSettings = ProjectSettings()) {
        self.projectSettings = projectSettings
    }
}

extension AppLocalSettingsService: AppLocalSettingsServiceProtocol {

    public var firebaseRemoteConfigKey: String { projectSettings.firebaseRemoteConfigKey }
}
