import Foundation

protocol MainViewInput {
    func reloadData()
    func updateTableView()
}

protocol MainViewOutput {
    
}



class FirstScreenPresenter {
    
    var view: MainViewInput?
    var coreDataManager: CoreDataManager
    
    init(view: MainViewInput, coreDataManager: CoreDataManager) {
        self.view = view
        self.coreDataManager = coreDataManager
    }
    
    func addDataToCoreData(text: String) {
        coreDataManager.addData(text)
        view?.updateTableView()
    }
    
    func deleteDataFromCoreData(at index: Int) {
        coreDataManager.deleteData(at: index)
        view?.updateTableView()
    }
}

extension FirstScreenPresenter: MainViewOutput {
    
}
