import Foundation

class MainAssembly {
    static func configureModule() -> FirstScreenViewController {
        let view = FirstScreenViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
