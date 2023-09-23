
//extension ProfileViewController: ProfileView {
//    func displayProfileData(name: String, birthDate: Date, gender: Gender) {
//        // Реализация отображения данных в вашем интерфейсе
//        nameLabel.text = name
//        datePicker.date = birthDate
//        genderSegmentedControl.selectedSegmentIndex = gender.rawValue
//    }
//
//    func enableEditingMode() {
//        // Реализация включения режима редактирования
//        nameLabel.isUserInteractionEnabled = true
//        datePicker.isUserInteractionEnabled = true
//        genderSegmentedControl.isUserInteractionEnabled = true
//    }
//
//    func disableEditingMode() {
//        // Реализация выключения режима редактирования
//        nameLabel.isUserInteractionEnabled = false
//        datePicker.isUserInteractionEnabled = false
//        genderSegmentedControl.isUserInteractionEnabled = false
//    }
//}

import UIKit

class ProfileViewController: UIViewController {
    var presenter: ProfilePresenter?
    var profileData: ProfileData?
    var initialProfileData: ProfileData = ProfileData(name: "Имя по умолчанию", birthDate: Date(), gender: .unknown)
    var enteredText: String?
    let nameCell = NameTableViewCell()
    let birthDateCell = BirthDateTableViewCell()
    let genderCell = GenderTableViewCell()


    let contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .zero
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        view.addSubview(contentView) // Добавьте contentView в view
            contentView.addSubview(tableView)
            contentView.addSubview(saveButton)
        
        let cells = [nameCell, birthDateCell, genderCell]
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor),
            
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: "nameCell")
        tableView.register(BirthDateTableViewCell.self, forCellReuseIdentifier: "birthDateCell")
        tableView.register(GenderTableViewCell.self, forCellReuseIdentifier: "genderCell")
    }
    
    @objc func buttonTapped() {
        let updatedName = nameCell.nameLabel.text ?? ""
        let updatedBirthDate = birthDateCell.birthDatePicker.date
        let selectedGenderIndex = genderCell.genderSegmentedControl.selectedSegmentIndex
        let selectedGender = Gender(rawValue: selectedGenderIndex) ?? .unknown
        
        let updatedProfileData = ProfileData(name: updatedName, birthDate: updatedBirthDate, gender: selectedGender)
        presenter?.saveProfileData(updatedProfileData)
    }

}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! NameTableViewCell
            cell.displayProfileName(name: profileData?.name)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "birthDateCell", for: indexPath) as! BirthDateTableViewCell
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let birthDateString = dateFormatter.string(from: initialProfileData.birthDate)
            //cell.displayBirthDate(date: birthDateString)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "genderCell", for: indexPath) as! GenderTableViewCell
            //cell.displayGender(gender: initialProfileData.gender.description)
            return cell
        }
    }
}

protocol ProfileView: ProfileViewController {
    func displayProfileData(name: String, birthDate: Date, gender: Gender)
    func enableEditingMode()
    func disableEditingMode()
}
