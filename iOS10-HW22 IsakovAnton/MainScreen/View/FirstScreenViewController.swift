
import UIKit

class FirstScreenViewController: UIViewController {
    
    var presenter: MainViewOutput?
    var data: [Profile] = []
    var enteredText: String?

    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите текст"
        textField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        textField.layer.cornerRadius = 14
        textField.contentVerticalAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(CellFirstView.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
    }

    private func setupUI() {
        view.addSubview(textField)
        view.addSubview(addButton)
        view.addSubview(tableView)

        let height = view.bounds.height // 812
        let width = view.bounds.width // 375
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: height * 0.1),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: width * 0.13),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -width * 0.13),

            addButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: height * 0.03),
            addButton.leftAnchor.constraint (equalTo: view.leftAnchor, constant: width * 0.13),
            addButton.rightAnchor.constraint (equalTo: view.rightAnchor, constant: -width * 0.13),
            addButton.heightAnchor.constraint(equalToConstant: 41),

            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func addButtonTapped(_ sender: UIButton) {
        guard let name = textField.text, !name.isEmpty else { return }
        presenter?.saveProfile(name: name)
    }
    
    func updateTableView() {
            tableView.reloadData()
        }
}

extension FirstScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let profile = data[indexPath.row]
        cell.textLabel?.text = profile.name
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedName = data[indexPath.row]
        let profileViewController = ProfileViewController()
        profileViewController.presenter?.initialProfileData.name = selectedName.name ?? "Имя не было найдено"
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension FirstScreenViewController: MainViewInput {
    func updateProfile(name: Profile) {
        data.append(name)
        reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}



