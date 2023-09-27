import Foundation

class SecondScreenPresenter {
    weak var view: SecondScreenView?
    var coreDataManager: CoreDataManager
    
    init(view: SecondScreenView, coreDataManager: CoreDataManager) {
        self.view = view
        self.coreDataManager = coreDataManager
    }
    
//    func loadProfileData() {
//        if let profile = coreDataManager.addUsers(name: String, gender: Int16, birthDate: Date) {
//            view?.displayProfileData(name: profile.name ?? "", birthDate: profile.birthDate ?? Date(), gender: Gender(rawValue: Int(profile.gender)) ?? .unknown)
//        }
//    }
    
    func saveProfileData(_ updatedProfileData: Profile) {
        coreDataManager.saveUsers()
    }
}

