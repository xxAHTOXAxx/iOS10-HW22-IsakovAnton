import Foundation
import UIKit
import CoreData

protocol ProfileViewInput: AnyObject {
    func setUser(user: Profile)
}

protocol ProfileViewOutput: AnyObject {
    func saveProfile(user: Profile)
    func getUser()
}

class ProfilePresenter {
    private weak var view: ProfileViewInput?
    var coreDataManager: CoreDataManager
    var user: Profile
   
    init(view: ProfileViewInput, coreDataManager: CoreDataManager, profileModel: Profile) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.user = profileModel
    }
}

extension ProfilePresenter: ProfileViewOutput {
    
    func getUser() {
        view?.setUser(user: user)
    }
    
    func saveProfile(user: Profile) {
        coreDataManager.saveUser(name: user.name ?? "Не удалось сохранить")
    }
}

