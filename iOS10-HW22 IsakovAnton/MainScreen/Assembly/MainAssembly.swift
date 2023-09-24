import Foundation

class MainAssembly {
    class func configureModule() -> FirstScreenViewController {
        let view = FirstScreenViewController()
        let presenter = MainPresenter(view: <#MainViewInput#>, coreDataManager: <#CoreDataManager#>)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
