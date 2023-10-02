import Foundation
import UIKit
import CoreData

protocol MainViewInput: AnyObject {
    func reloadData()
    func updateTableView()
    func updateProfile(name: Profile)
}

protocol MainViewOutput: AnyObject {
    func saveProfile(name: String)
    func loadUsers()
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
        coreDataManager.deleteUsers(user: user)
    }
}

extension MainPresenter: MainViewOutput {

    func saveProfile(name: String) {
        let profile = coreDataManager.saveUser(name: name)
        guard let profile = profile else { return }
        view?.updateProfile(name: profile)
    }
}

extension MainPresenter {
    func loadUsers() {
        _ = coreDataManager.getUsers()
        if let view = view {
            view.updateTableView()
        } else {
            print("Ошибка: view не реализует протокол MainViewInput")
        }
    }
}



