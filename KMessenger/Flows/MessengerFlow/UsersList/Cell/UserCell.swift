import UIKit
import RxSwift

final class UserCell: BaseTableViewCell {
    
    var onProfile: UserHandler?
    
    private var source: User?
    private let disposeBag = DisposeBag()
    
    private func body(config: User) -> UIView {
        VStack {
            HStack {
                UIImageView()
                    .size(.init(width: 72, height: 72))
                    .cornerRadius(36)
                    .contentMode(.scaleAspectFit)
                    .setImage(withUrl: config.avatarUrl)
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
                    Label(text: config.department)
                        .setFont(.systemFont(ofSize: 13, weight: .light))
                    FlexibleSpacer()
                }
                .layoutMargins(hInset: 16)
                FlexibleSpacer()
            }
            .onTap(store: disposeBag) { [weak self] in
                self?.onProfile?(config)
            }
        }
    }
    
    private func setupUi() {
            guard let source = source else { return }
            body(config: source).embedIn(contentView)
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        source = nil
    }

    func set(model: User) {
        source = model
        setupUi()
    }
}
