
import Foundation

struct ProfileData {
    var name: String
    var birthDate: Date
    var gender: Gender
}

enum Gender: Int {
    case male
    case female
    case unknown

    var description: String {
        switch self {
        case .male: return "Мужской"
        case .female: return "Женский"
        case .unknown: return "Неизвестный"
        }
    }
}

