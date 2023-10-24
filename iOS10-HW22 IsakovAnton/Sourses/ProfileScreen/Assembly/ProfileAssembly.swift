import Foundation

class ProfileAssembly {
    static func configureModule(user: Profile) -> ProfileViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view, profileModel: user)
        view.presenter = presenter
        return view
    }
}
