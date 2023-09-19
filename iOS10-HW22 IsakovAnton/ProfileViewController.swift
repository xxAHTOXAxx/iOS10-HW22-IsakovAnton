import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenter?
    var initialProfileData: ProfileData = ProfileData(name: "Имя по умолчанию", birthDate: Date(), gender: .unknown)
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    let genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Мужской", "Женский"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = ProfilePresenter(view: self, profileData: initialProfileData)
    }

    private func setupUI() {
        
        view.addSubview(nameLabel)
        view.addSubview(datePicker)
        view.addSubview(genderSegmentedControl)
        view.addSubview(saveButton)

        // Настройка constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            genderSegmentedControl.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            saveButton.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func buttonTapped() {
        // Обработка сохранения изменений
            let selectedGenderIndex = genderSegmentedControl.selectedSegmentIndex
            let selectedGender = Gender(rawValue: selectedGenderIndex) ?? .unknown // Замените на вашу логику получения выбранного пола

            // Создайте объект с обновленными данными
            let updatedProfileData = ProfileData(name: nameLabel.text ?? "", birthDate: datePicker.date, gender: selectedGender)

            // Передайте обновленные данные презентеру второго экрана
            presenter?.saveProfileData(updatedProfileData)
    }
    
    
}

protocol ProfileView: ProfileViewController {
    func displayProfileData(name: String, birthDate: Date, gender: Gender)
    func enableEditingMode()
    func disableEditingMode()
}


extension ProfileViewController: ProfileView {
    func displayProfileData(name: String, birthDate: Date, gender: Gender) {
        // Реализация отображения данных в вашем интерфейсе
        nameLabel.text = name
        datePicker.date = birthDate
        genderSegmentedControl.selectedSegmentIndex = gender.rawValue
    }

    func enableEditingMode() {
        // Реализация включения режима редактирования
        nameLabel.isUserInteractionEnabled = true
        datePicker.isUserInteractionEnabled = true
        genderSegmentedControl.isUserInteractionEnabled = true
    }

    func disableEditingMode() {
        // Реализация выключения режима редактирования
        nameLabel.isUserInteractionEnabled = false
        datePicker.isUserInteractionEnabled = false
        genderSegmentedControl.isUserInteractionEnabled = false
    }
}
