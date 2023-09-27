import Foundation
import UIKit
import CoreData

protocol MainViewInput {
    func reloadData()
    func updateTableView()
}

protocol MainViewOutput {
    
}

class MainPresenter {
    
    var view: MainViewInput?
    var coreDataManager: CoreDataManager
    
    init(view: MainViewInput, coreDataManager: CoreDataManager) {
        self.view = view
        self.coreDataManager = coreDataManager
    }
    
    func addDataToCoreData(name: String, gender: Int16, birthDate: Date) {
        coreDataManager.addUsers(name: name, gender: gender, birthDate: birthDate)
        view?.updateTableView()
    }
    
    func deleteDataFromCoreData(user:Profile) {
        coreDataManager.deleteUsers(user: user)
    }
}

extension MainPresenter: MainViewOutput {
    
}

extension MainPresenter {
    
    func loadUsers() {
        let data = coreDataManager.getUsers()
        if let view = view {
            view.updateTableView()
        } else {
            print("Ошибка: view не реализует протокол MainViewInput")
        }
    }
    
}



