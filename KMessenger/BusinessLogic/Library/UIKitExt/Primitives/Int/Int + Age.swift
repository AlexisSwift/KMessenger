class Helper {
    static func formatAs(age: Int) -> String {
        let num = age % 10
        
        if age > 10 && age < 21 {
            return "\(age) лет"
        }
        
        if num == 1 {
            return "\(age) год"
        }
        
        if num > 1 && num < 5 {
            return "\(age) года"
        }
        
        return "\(age) лет"
    }
}

extension Int {
    var formatAge: String { Helper.formatAs(age: self) }
}
