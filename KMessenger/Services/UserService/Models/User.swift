import Foundation

struct User: Decodable {
    let id: String
    let avatarUrl: String
    let firstName: String
    let lastName: String
    let userTag: String
    let department: Department
    let position: String
    let birthday: String
    let phone: String
}

// MARK: - Helper
extension User {
    
    var birthdayDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: birthday)
    }
    
    var birthdayExtended: String? {
        guard let birthdayDate = birthdayDate else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "d MMMM yyyy"
        
        return dateFormatter
            .string(from: birthdayDate)
    }
    
    var age: Int? {
        guard let birthdayDate = birthdayDate else { return nil }
        
        return Calendar.current.dateComponents([.year], from: birthdayDate, to: Date()).year ?? nil
    }
    
    static func mockup() -> User {
        User(id: "", avatarUrl: "", firstName: "", lastName: "", userTag: "", department: Department.ios, position: "", birthday: "", phone: "")
    }
}
