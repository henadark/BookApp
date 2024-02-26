import SwiftUI
import Resources
import UIStyleKit
import Helpers
import AppExtensions

public struct PrimaryButton: View {

    public let title: String
    public let action: VoidCompletion

    public init(
        title: String,
        action: @escaping VoidCompletion
    ) {
        self.title = title
        self.action = action
    }

    public var body: some View {

        Button(action: action) {
            Text(title)
                .font(.appSubheadline)
                .padding(.vertical, AppPadding.x)
                .padding(.horizontal, 100)
        }
        .buttonStyle(.primary())
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    PrimaryButton(title: "Title", action: {})
        .padding(AppPadding.x)
        .background(Color.primaryWhite)
}
