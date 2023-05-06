//
//  InvitesAllotmentTableViewCell.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import UIKit

class InvitesAllotmentTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let numberLabel = UILabel()
    let numberTextField = UITextField()
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        nameLabel.numberOfLines = 0
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        numberLabel.font = UIFont.systemFont(ofSize: 13, weight: .heavy)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberTextField.font = UIFont.systemFont(ofSize: 13, weight: .heavy)
        numberTextField.borderStyle = .roundedRect
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.keyboardType = .numberPad
        numberTextField.placeholder = "0"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(numberTextField)

        contentView.addSubview(stackView)
    }

    func setupConstraints() {
        let verticalPadding: CGFloat = 20.0

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalPadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalPadding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(inviteAllotment: InviteAllotment) {
        nameLabel.text = inviteAllotment.user_name
        numberLabel.text = "Number of invites"
        numberTextField.text = String(inviteAllotment.num_invites)
    }

}
