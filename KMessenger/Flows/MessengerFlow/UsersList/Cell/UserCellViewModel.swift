import UIKit

final class UserCellViewModel: CellViewModelFaceless, CellViewModelHeightable {
    typealias CellType = UserCell

    var height: CGFloat = UITableView.automaticDimension
    var source: User
    var onUserProfileScreen: UserHandler?

    init(source: User) {
        self.source = source
    }

    func configure(cell: UserCell) {
        cell.set(model: source)
        cell.onProfile = onUserProfileScreen
    }
}
