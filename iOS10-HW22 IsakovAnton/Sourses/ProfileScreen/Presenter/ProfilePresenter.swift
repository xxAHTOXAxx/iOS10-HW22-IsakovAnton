import Foundation
import UIKit
import CoreData

protocol ProfileViewInput: AnyObject {
    func setUser(user: Profile)
}

protocol ProfileViewOutput: AnyObject {
    func saveProfile(clousure: (Bool) -> ())
    func getUser()
}

class ProfilePresenter {
    private weak var view: ProfileViewInput?
    private let coreDataManager = CoreDataManager()
    private var user: Profile
   
    init(view: ProfileViewInput, profileModel: Profile) {
        self.view = view
        self.user = profileModel
    }
}

extension ProfilePresenter: ProfileViewOutput {
    
    func getUser() {
        view?.setUser(user: user)
    }
    
    func saveProfile(clousure: (Bool) -> ()) {
        coreDataManager.saveProfile(clousure: clousure)
    }
}

