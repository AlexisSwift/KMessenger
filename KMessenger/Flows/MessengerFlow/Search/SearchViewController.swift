import UIKit
import RxSwift
import SnapKit

class SearchViewController: UIViewController {
    
    private(set) var state = State()
    var onUserScreen: UserHandler?
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        self.view.backgroundColor = .white
        
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        state.filteredUsers = state.users
        searchBar.delegate = self
        
        searchBar.barTintColor = .white
        searchBar.layer.cornerRadius = 16
        searchBar.placeholder = "Введи имя, тег, почту..."
        searchBar.placeholderLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        searchBar.tintColor = .gray
        searchBar.searchField?.textColor = .black
        searchBar.searchBarStyle = .minimal
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(16)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin)
            make.right.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - TableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.font = .systemFont(ofSize: 32, weight: .heavy)
        cell.textLabel?.textColor = .black
        
        guard indexPath.row < state.filteredUsers.count else {
            return cell
        }
        
        cell.textLabel?.text = state.filteredUsers[indexPath.row].firstName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < state.filteredUsers.count  else {
            return
        }
        
        let user = state.filteredUsers[indexPath.row]
        self.onUserScreen?(user)
        
    }
}

// MARK: - Controller's State
extension SearchViewController {
    final class State {
        var users = [
            TestUser(avatarUrl: "https://cdn.fakercloud.com/avatars/marrimo_128.jpg", firstName: "Dee", lastName: "Reichert", userTag: "LK", department: "back_office", position: "Technician", birthday: "2004-08-02", phone: "802-623-1785")
        ]
        var filteredUsers: [TestUser] = []
    }
}

// MARK: - SearchView
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText != "" else {
            state.filteredUsers = state.users
            self.tableView.reloadData()
            return
        }
        
        state.filteredUsers = []
        
        for user in state.users {
            if user.firstName.uppercased().contains(searchText.uppercased()) {
                state.filteredUsers.append(user)
            }
        }
        self.tableView.reloadData()
    }
}
