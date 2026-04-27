
import Foundation

struct NoteValidator {
    static func validate(_ value: String) -> String? {
        if value.isEmpty {
            return "Note cannot be empty."
        }

        if value.count < 3 {
            return "Note must be at least 3 characters."
        }

        if value.count > 120 {
            return "Note must be no longer than 120 characters."
        }

        if value.rangeOfCharacter(from: .decimalDigits) != nil {
            return "Numbers are not allowed."
        }

        return nil
    }
}
