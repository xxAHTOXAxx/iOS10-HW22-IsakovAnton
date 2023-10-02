import Foundation

class MainAssembly {
    static func configureModule() -> FirstScreenViewController {
        let view = FirstScreenViewController()
        let coreData = CoreDataManager()
        let presenter = MainPresenter(view: view, coreDataManager: coreData)
        view.presenter = presenter
        return view
    }
}
