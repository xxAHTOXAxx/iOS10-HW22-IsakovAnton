import Foundation
import UIKit
import CoreData

protocol ProfileViewInput: AnyObject {
    
}

protocol ProfileViewOutput: AnyObject {
    
}

class ProfilePresenter {
    private weak var view: ProfileViewInput?
    var coreDataManager: CoreDataManager
    var profileModel: Profile
   
    init(view: ProfileViewInput, coreDataManager: CoreDataManager, profileModel: Profile) {
        self.view = view
        self.coreDataManager = coreDataManager
        self.profileModel = profileModel
    }
}

extension ProfilePresenter: ProfileViewOutput {

}
