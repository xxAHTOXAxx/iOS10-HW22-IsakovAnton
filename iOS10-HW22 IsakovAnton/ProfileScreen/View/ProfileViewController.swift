import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfileViewOutput?
    
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 5.0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthDatePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
       datePicker.datePickerMode = .date
       datePicker.translatesAutoresizingMaskIntoConstraints = false
       datePicker.isUserInteractionEnabled = false
       return datePicker
   }()
    
    let genderSegmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: ["Мужской", "Женский"])
       segmentedControl.translatesAutoresizingMaskIntoConstraints = false
       segmentedControl.isUserInteractionEnabled = false
       return segmentedControl
   }()
    
    private func setupNavigationBar() {
        let editButtonTitle = isEditing ? "Done" : "Edit"
        let editButton = UIBarButtonItem(title: editButtonTitle, style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = editButton
    }

    @objc func editButtonTapped() {
        // Обработчик нажатия кнопки "Edit"
        if isEditing {
            setEditing(false, animated: true)
            navigationItem.rightBarButtonItem?.title = "Edit"
            birthDatePicker.isUserInteractionEnabled = false
            genderSegmentedControl.isUserInteractionEnabled = false
        } else {
            setEditing(true, animated: true)
            navigationItem.rightBarButtonItem?.title = "Done"
            birthDatePicker.isUserInteractionEnabled = true
            genderSegmentedControl.isUserInteractionEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupNavigationBar()
        presenter?.getUser()
    }

    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(birthDatePicker)
        view.addSubview(genderSegmentedControl)
        view.addSubview(saveButton)
        
        let height = view.bounds.height // 812
        let width = view.bounds.width // 375

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: height * 0.2),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),

            birthDatePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            birthDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
    
            genderSegmentedControl.topAnchor.constraint(equalTo: birthDatePicker.bottomAnchor, constant: 20),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -height * 0.2),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func buttonTapped() {
        let updatedName = nameLabel.text ?? ""
        let updatedBirthDate = birthDatePicker.date
        let selectedGenderIndex = genderSegmentedControl.selectedSegmentIndex
        let selectedGender = Gender(rawValue: selectedGenderIndex) ?? .unknown
        let updatedProfileData = ProfileModel(name: updatedName, birthDate: updatedBirthDate, gender: selectedGender)
    }
}

extension ProfileViewController: ProfileViewInput {
    
    func setUser(user: Profile) {
        nameLabel.text = user.name
        birthDatePicker.date = user.birthDate ?? Date()
        genderSegmentedControl.selectedSegmentIndex = Int(user.gender)
    }
}
