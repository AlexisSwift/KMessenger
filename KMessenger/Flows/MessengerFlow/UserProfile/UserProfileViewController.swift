import RxSwift

final class UserProfileViewController: UIViewController {
    typealias ViewModel = UserProfileViewModel
    
    private var viewModel: ViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.view.background(Palette.backgroundPrimary)
        
        self.viewModel.$state
            .drive { [weak self] state in
                guard let self = self else { return }
                
                self.body(state: state).embedIn(self.view)
                
            }.disposed(by: disposeBag)
    }
}

// MARK: - UI
extension UserProfileViewController {
    private func body(state: ViewModel.State) -> UIView {
        VStack {
            ViewWithData (state.$userProfile.map({ user in
                UserProfileView.Config(image: user.avatarUrl, firstName: user.firstName, lastName: user.lastName, userTag: user.userTag, deportament: user.department, birthday: user.birthday, phone: user.phone)
            })) { config in
                UserProfileView(config: config)
            }
        }
    }
}

extension UserProfileViewController {
    enum Action {
        case load
    }
    
    enum InputEvent {
        case error
    }
}
