//
//  EventDetailsViewController.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import UIKit

class EventDetailsViewController: UIViewController {

    let nameLabel = UILabel()
    let eventNameLabel = UILabel()
    let locationLabel = UILabel()
    let locationTextLabel = UILabel()
    let fraternityLabel = UILabel()
    let fraternityTextLabel = UILabel()
    let startLabel = UILabel()
    let startTextLabel = UILabel()
    let endLabel = UILabel()
    let endTextLabel = UILabel()
    let descriptionLabel = UILabel()
    let descriptionTextView = UITextView()
    
    init(event: Event) {
        super.init(nibName: nil, bundle: nil)
        eventNameLabel.text = event.name
        locationTextLabel.text = event.location
        descriptionTextView.text = event.description
        fraternityTextLabel.text = event.hosting_fraternities.map { $0.name }.joined(separator: ", ")
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let old_start = dateFormatter.date(from: event.start_date)
        let old_end = dateFormatter.date(from: event.end_date)
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy h:mm a"

        
        startTextLabel.text = dateFormatter.string(from: old_start!)
        endTextLabel.text = dateFormatter.string(from: old_end!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        nameLabel.text = "EVENT NAME"
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.textColor = .systemGray3
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventNameLabel)
        
        locationLabel.text = "LOCATION"
        locationLabel.font = .systemFont(ofSize: 14)
        locationLabel.textColor = .systemGray3
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationLabel)
        locationTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationTextLabel)
        
        fraternityLabel.text = "FRATERNITIES"
        fraternityLabel.font = .systemFont(ofSize: 14)
        fraternityLabel.textColor = .systemGray3
        fraternityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fraternityLabel)
        fraternityTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fraternityTextLabel)
        
        startLabel.text = "START"
        startLabel.font = .systemFont(ofSize: 14)
        startLabel.textColor = .systemGray3
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startLabel)
        startTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startTextLabel)
        
        endLabel.text = "END"
        endLabel.font = .systemFont(ofSize: 14)
        endLabel.textColor = .systemGray3
        endLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(endLabel)
        endTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(endTextLabel)
        
        descriptionLabel.text = "DESCRIPTION"
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray3
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        descriptionTextView.layer.cornerRadius = 12
        descriptionTextView.backgroundColor = .systemGray4
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.clear.cgColor
        descriptionTextView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.isEditable = false
        view.addSubview(descriptionTextView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            eventNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            eventNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            eventNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            eventNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationTextLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            locationTextLabel.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor),
            locationTextLabel.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor),
            locationTextLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            fraternityLabel.topAnchor.constraint(equalTo: locationTextLabel.bottomAnchor, constant: 20),
            fraternityLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            fraternityTextLabel.topAnchor.constraint(equalTo: fraternityLabel.bottomAnchor, constant: 10),
            fraternityTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            fraternityTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            fraternityTextLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: fraternityTextLabel.bottomAnchor, constant: 20),
            startLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            startTextLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 10),
            startTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            startTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            startTextLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            endLabel.topAnchor.constraint(equalTo: startTextLabel.bottomAnchor, constant: 20),
            endLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            endTextLabel.topAnchor.constraint(equalTo: endLabel.bottomAnchor, constant: 10),
            endTextLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            endTextLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            endTextLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: endTextLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
    
}
