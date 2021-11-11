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
        VStack(alignment: .center){
            UIImageView()
                .size(.init(width: 104, height: 104))
                .cornerRadius(48)
                .contentMode(.scaleAspectFit)
                .setImage(withUrl: config.image)
            HStack {
                Label(text: config.firstName + " " + config.lastName)
                    .setFont(.systemFont(ofSize: 24, weight: .bold))
                    .setTextColor(.black)
                Spacer(width: 4)
                Label(text: config.userTag)
                    .setFont(.systemFont(ofSize: 17, weight: .medium))
                    .setTextColor(.gray)
            }
            Spacer(height: 12)
            Label (text: config.deportament)
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
