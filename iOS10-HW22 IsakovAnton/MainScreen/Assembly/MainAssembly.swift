import Foundation

class MainAssembly {
    class func configureModule() -> FirstScreenViewController {
        let view = FirstScreenViewController()
        let presenter = FirstScreenPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
