import UIKit
import RxSwift

final class UserCell: BaseTableViewCell {
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Handler
    var onProfile: UserHandler?

    func set(model: User) {
        body(config: model).embedIn(contentView)
        backgroundColor = Palette.backgroundUserProfile
    }
}

// MARK: - UI
private extension UserCell {
    private func body(config: User) -> UIView {
        VStack {
            HStack {
                UIImageView()
                    .size(.init(width: 72, height: 72))
                    .cornerRadius(36)
                    .contentMode(.scaleAspectFit)
                    .setImage(withUrl: config.avatarUrl, placeholder: Image.testImage())
                VStack(alignment: .leading) {
                    Spacer(height: 22)
                    HStack {
                        Label(text: config.firstName + (" ") + config.lastName)
                            .setFont(.systemFont(ofSize: 16, weight: .medium))
                        Spacer(width: 4)
                        Label(text: config.userTag)
                            .setTextColor(.gray)
                            .setFont(.systemFont(ofSize: 14, weight: .medium))
                    }
                    Label(text: config.department.title)
                        .setFont(.systemFont(ofSize: 13, weight: .light))
                    FlexibleSpacer()
                }
                .layoutMargins(hInset: 16)
                FlexibleSpacer()
            }
        }.onTap(store: disposeBag) { [weak self] in
            self?.onProfile?(config)
        }
    }
}
