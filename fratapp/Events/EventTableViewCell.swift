//
//  EventTableViewCell.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let fraternitiesLabel = UILabel()
    let locationLabel = UILabel()
    let startLabel = UILabel()
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

        fraternitiesLabel.font = UIFont.systemFont(ofSize: 13, weight: .heavy)
        fraternitiesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.font = UIFont.systemFont(ofSize: 13, weight: .heavy)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startLabel.font = UIFont.systemFont(ofSize: 13, weight: .heavy)
        startLabel.translatesAutoresizingMaskIntoConstraints = false


        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(fraternitiesLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(startLabel)

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

    func configure(eventObject: Event) {
        nameLabel.text = eventObject.name
        fraternitiesLabel.text = "Fraternities: " + eventObject.hosting_fraternities.map { $0.name }.joined(separator: ", ")
        locationLabel.text = "Location: " + eventObject.location
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let components = calendar.dateComponents([.day, .month], from: dateFormatter.date(from:eventObject.start_date)!)
        let date = String(components.day!) + "/" + String(components.month!)
        startLabel.text = "Date: " + date
    }

}

