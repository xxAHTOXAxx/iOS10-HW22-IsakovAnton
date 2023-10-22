import Foundation
import UIKit
import CoreData

protocol MainViewInput: AnyObject {
    func updateProfile(name: Profile)
    func updateView(array: [Profile])
}

protocol MainViewOutput: AnyObject {
    func saveProfile(name: String)
    func loadUsers()
    func deleteDataFromCoreData(user: Profile)
}

class MainPresenter {
    
    private weak var view: MainViewInput?
    private let coreDataManager = CoreDataManager()
    
    init(view: MainViewInput) {
        self.view = view
    }
    
    func deleteDataFromCoreData(user: Profile) {
        let isSuccess = coreDataManager.deleteUsers(user: user)
           if isSuccess {
               view?.updateView(array: coreDataManager.getUsers())
           }
    }
}

extension MainPresenter: MainViewOutput {

    func saveProfile(name: String) {
        let profile = coreDataManager.saveUser(name: name)
        guard let profile = profile else { return }
        view?.updateProfile(name: profile)
    }
    
    func loadUsers() {
        let usersArray = coreDataManager.getUsers()
        view?.updateView(array: usersArray)
    }
}
