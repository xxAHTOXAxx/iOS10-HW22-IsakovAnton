import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfileViewOutput?
    private var user: Profile?
    private var nameUser: String?
    private var gender: Int16?
    private var birthDate: Date?
    
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
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        view.addSubview(textField)
        view.addSubview(birthDatePicker)
        view.addSubview(genderSegmentedControl)
        view.addSubview(saveButton)
        
        let height = view.bounds.height // 812
        let width = view.bounds.width // 375

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: height * 0.2),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),

            birthDatePicker.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
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
        guard let name = textField.text, !name.isEmpty else { return }
        user?.name = textField.text
        user?.birthDate = birthDatePicker.date
        user?.gender = Int16(genderSegmentedControl.selectedSegmentIndex)
        presenter?.saveProfile(clousure: { isSave in
            if isSave {
                nameUser = user?.name
                birthDate = user?.birthDate ?? Date()
                gender = user?.gender
            } else {
                user?.name = nameUser
                user?.birthDate = birthDate
                user?.gender = gender ?? Int16()
                textField.text = user?.name
                birthDatePicker.date = user?.birthDate ?? Date()
                genderSegmentedControl.selectedSegmentIndex = Int(user?.gender ?? Int16())
            }
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.saveButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.saveButton.transform = .identity
            }
            }
    }
}

extension ProfileViewController: ProfileViewInput {
    
    func setUser(user: Profile) {
        textField.text = user.name
        birthDatePicker.date = user.birthDate ?? Date()
        genderSegmentedControl.selectedSegmentIndex = Int(user.gender)
        self.user = user
        nameUser = user.name
        birthDate = user.birthDate ?? Date()
        gender = user.gender
    }
}
