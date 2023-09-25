import Foundation

class MainAssembly {
    class func configureModule() -> FirstScreenViewController {
        let view = FirstScreenViewController()
        let coreData = CoreDataManager()
        let presenter = MainPresenter(view: view, coreDataManager: coreData)
        presenter.view = view
        return view
    }
}
