import Foundation

class SecondScreenPresenter {
    weak var view: SecondScreenView?
    var coreDataManager: CoreDataManager
    
    init(view: SecondScreenView, coreDataManager: CoreDataManager) {
        self.view = view
        self.coreDataManager = coreDataManager
    }
    
//    func saveProfileData(_ updatedProfileData: Profile) {
//        coreDataManager.saveUser(name: updatedProfileData.name!)
//    }
}

protocol ProfileViewInput: AnyObject {
    
}

protocol ProfileViewOutput: AnyObject {
    
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
