
import Foundation
import UIKit

class GenderTableViewCell: UITableViewCell {
    
     let genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Мужской", "Женский"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.isUserInteractionEnabled = false
        return segmentedControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(genderSegmentedControl)

        NSLayoutConstraint.activate([
            genderSegmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            genderSegmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
