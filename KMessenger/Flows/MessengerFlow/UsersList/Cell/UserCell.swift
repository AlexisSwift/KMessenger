import UIKit

final class UserCell: BaseTableViewCell {
    
    private var source: User?
    
    private func body(source: User) -> UIView {
        VStack {
            HStack {
                UIImageView()
                    .size(.init(width: 72, height: 72))
                    .cornerRadius(36)
                    .contentMode(.scaleAspectFit)
                    .setImage(withUrl: source.avatarUrl)
                VStack(alignment: .leading) {
                    Spacer(height: 22)
                    HStack {
                        Label(text: source.firstName + (" ") + source.lastName)
                            .setFont(.systemFont(ofSize: 16, weight: .medium))
                        Spacer(width: 4)
                        Label(text: source.userTag)
                            .setTextColor(.gray)
                            .setFont(.systemFont(ofSize: 14, weight: .medium))
                    }
                    Label(text: source.department)
                        .setFont(.systemFont(ofSize: 13, weight: .light))
                    FlexibleSpacer()
                }
                .layoutMargins(hInset: 16)
                FlexibleSpacer()
            }
            .layoutMargins(hInset: 16)
            FlexibleSpacer()
        }
    }
    
    private func setupUi() {
            guard let source = source else { return }
            body(source: source).embedIn(contentView)
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
