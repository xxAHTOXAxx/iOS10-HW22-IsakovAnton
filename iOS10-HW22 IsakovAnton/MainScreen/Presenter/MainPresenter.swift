import Foundation
import UIKit
import CoreData

protocol MainViewInput: AnyObject {
    func reloadData()
    func updateTableView()
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
    var coreDataManager: CoreDataManager
    
    init(view: MainViewInput, coreDataManager: CoreDataManager) {
        self.view = view
        self.coreDataManager = coreDataManager
    }
    
    func addDataToCoreData(name: String, gender: Int16, birthDate: Date) {
        coreDataManager.addUsers(name: name, gender: gender, birthDate: birthDate)
        view?.updateTableView()
    }
    func deleteDataFromCoreData(user: Profile) {
        let isSuccess = coreDataManager.deleteUsers(user: user)
           if isSuccess {
               view?.updateView(array: coreDataManager.getUsers())
           } else {
               // Обработка случая, когда удаление не удалось
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
