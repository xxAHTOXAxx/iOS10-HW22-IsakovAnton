
import Foundation
import UIKit

class BirthDateTableViewCell: UITableViewCell {
    
    let birthDatePicker: UIDatePicker = {
            let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            return datePicker
        }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(birthDatePicker)

        NSLayoutConstraint.activate([
            birthDatePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            birthDatePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            birthDatePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
