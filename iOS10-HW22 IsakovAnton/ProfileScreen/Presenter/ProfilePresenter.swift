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


class ProfilePresenter {
    weak var view: ProfileView?
        var profileData: ProfileData
        var initialProfileData: ProfileData

        init(view: ProfileView, profileData: ProfileData, initialProfileData: ProfileData) {
            self.view = view
            self.profileData = profileData
            self.initialProfileData = initialProfileData
        }

    func saveProfileData(_ data: ProfileData) {
            profileData = data
        }
}
