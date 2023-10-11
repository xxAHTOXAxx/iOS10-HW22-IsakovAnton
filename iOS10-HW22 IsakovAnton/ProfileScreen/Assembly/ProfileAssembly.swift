import Foundation

class ProfileAssembly {
    static func configureModule(user: Profile) -> ProfileViewController {
        let view = ProfileViewController()
        let coreData = CoreDataManager()
        let presenter = ProfilePresenter(view: view, coreDataManager: coreData, profileModel: user)
        view.presenter = presenter
        return view
    }
}
