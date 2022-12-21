enum Department: String, Codable {
    case all
    case design
    case analytics
    case management
    case ios
    case android
    case qa
    case frontend
    case backend
    case hr
    case pr
    case backOffice = "back_office"
    case support
}

extension Department: CaseIterable {
    
    var title: String {
        switch self {
        case .all:
            return L10n.allTabTitle()
        case .design:
            return L10n.designTabTitle()
        case .analytics:
            return L10n.analyticsTabTitle()
        case .management:
            return L10n.managementTabTitle()
        case .ios:
            return L10n.iosTabTitle()
        case .android:
            return L10n.androidTabTitle()
        case .qa:
            return L10n.qaTabTitle()
        case .frontend:
            return L10n.frontendTabTitle()
        case .backend:
            return L10n.backendTabTitle()
        case .hr:
            return L10n.hrTabTitle()
        case .pr:
            return L10n.prTabTitle()
        case .backOffice:
            return L10n.backOfficeTabTitle()
        case .support:
            return L10n.supportTabTitle()
        }
    }
}
