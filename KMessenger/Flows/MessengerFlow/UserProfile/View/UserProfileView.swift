import RxSwift

final class UserProfileView: UIView {
    
    private let disposeBag = DisposeBag()
    
    init(config: Config) {
        super.init(frame: .zero)
        body(config: config).embedInWithSafeArea(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func body(config: Config) -> UIView {
        VStack{
            VStack(alignment: .center) {
                UIImageView()
                    .size(.init(width: 104, height: 104))
                    .cornerRadius(48)
                    .contentMode(.scaleAspectFit)
                    .setImage(withUrl: config.image)
                Spacer(height: 24)
                HStack {
                    Label(text: config.firstName + " " + config.lastName)
                        .setFont(.systemFont(ofSize: 24, weight: .bold))
                        .setTextColor(.black)
                    Spacer(width: 4)
                    Label(text: config.userTag)
                        .setFont(.systemFont(ofSize: 17, weight: .medium))
                        .setTextColor(.systemGray)
                }
                Spacer(height: 12)
                Label (text: config.deportament)
                    .setFont(.systemFont(ofSize: 13, weight: .regular))
                    .setTextColor(.black)
                Spacer(height: 24)
            }
            .background(Palette.backgroundUserProfile)
            VStack {
                HStack {
                    UIImageView(image: UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(scale: .large)))
                        .contentMode(.left)
                        .tintColor(.black)
                    Spacer(width: 14)
                    Label(text: config.birthday)
                        .setFont(.systemFont(ofSize: 16, weight: .medium))
                    FlexibleGroupedSpacer(groupId: 1)
                    Label(text: config.birthday)
                        .setTextColor(.gray)
                        .setFont(.systemFont(ofSize: 16, weight: .medium))
                }
                Spacer(height: 48)
                HStack {
                    UIImageView(image: UIImage(systemName: "phone", withConfiguration: UIImage.SymbolConfiguration(scale: .large)))
                        .contentMode(.left)
                        .tintColor(.black)
                    Spacer(width: 14)
                    Button(title: "+7 " + config.phone)
                        .setFont(.systemFont(ofSize: 16, weight: .medium))
                        .setTitleColor(.black)
                        .onTap(store: disposeBag) {
                            if let url = URL(string: "tel://" + config.phone) {
                                        if UIApplication.shared.canOpenURL(url) {
                                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                        }
                            }
                        }
                    FlexibleSpacer()
                }
            }
            .linkSpacers()
            .layoutMargins(vInset: 27, hInset: 18)
            FlexibleSpacer()
        }
    }
}

extension UserProfileView {
    struct Config {
        let image: String
        let firstName: String
        let lastName: String
        let userTag: String
        let deportament: String
        let birthday: String
        let phone: String
    }
}
