import RxSwift

final class UserProfileViewController: UIViewController {
    typealias ViewModel = UsersListViewModel
    
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
        viewModel.handle(.load)
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
            Label(text: "hi")
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
