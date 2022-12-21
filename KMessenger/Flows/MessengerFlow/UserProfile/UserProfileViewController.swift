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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.background(Palette.backgroundPrimary)
        
        self.viewModel.$state
            .drive { [weak self] state in
                guard let self = self else { return }
                
                self.body(config: state).embedIn(self.view)
                
            }.disposed(by: disposeBag)
    }
}

// MARK: - UI
extension UserProfileViewController {
    private func body(config: ViewModel.State) -> UIView {
        ViewWithData(config.$userProfile) { user in
            UserProfileView(config: user)
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
