//
//  CreateEventViewController.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import UIKit

class CreateEventViewController: UIViewController {

    let nameTextField = UITextField()
    let descriptionTextView = UITextView()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    let locationTextField = UITextField()
    let postButton = UIButton()
    let publicSwitch = UISwitch()
    var event : Event?
    var update = false

    weak var delegate: EventDelegate?

    init(delegate: EventDelegate, event: Event?) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        if let event = event {
            nameTextField.text = event.name
            descriptionTextView.text = event.description
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            startDatePicker.date = dateFormatter.date(from:event.start_date)!
            endDatePicker.date = dateFormatter.date(from:event.end_date)!
            locationTextField.text = event.location
            publicSwitch.isOn = event.is_public
            self.event = event
            update = true
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        nameTextField.placeholder = "What is this event named?"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.clipsToBounds = true
        nameTextField.layer.cornerRadius = 5
        nameTextField.backgroundColor = .systemGray4
        nameTextField.font = .systemFont(ofSize: 20)
        view.addSubview(nameTextField)
        
        descriptionTextView.text = descriptionTextView.text == "" ? "What is the description?" : descriptionTextView.text
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.clipsToBounds = true
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.backgroundColor = .systemGray4
        descriptionTextView.font = .systemFont(ofSize: 15)
        view.addSubview(descriptionTextView)
        
        
        locationTextField.placeholder = "Where is this happening?"
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        locationTextField.clipsToBounds = true
        locationTextField.layer.cornerRadius = 5
        locationTextField.backgroundColor = .systemGray4
        locationTextField.font = .systemFont(ofSize: 20)
        view.addSubview(locationTextField)
        
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.timeZone = NSTimeZone.local
        startDatePicker.minimumDate = Date()
        startDatePicker.preferredDatePickerStyle = .compact
        startDatePicker.addTarget(self, action: #selector(startDate), for: .valueChanged)

        view.addSubview(startDatePicker)
        
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.timeZone = NSTimeZone.local
        endDatePicker.maximumDate = startDatePicker.date.addingTimeInterval(TimeInterval(86400))
        endDatePicker.minimumDate = startDatePicker.date
        endDatePicker.preferredDatePickerStyle = .compact
        view.addSubview(endDatePicker)
        
        publicSwitch.translatesAutoresizingMaskIntoConstraints = false
        publicSwitch.setOn(true, animated: false)
        view.addSubview(publicSwitch)

        postButton.setTitle("Post", for: .normal)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.backgroundColor = .systemBlue
        postButton.layer.cornerRadius = 15
        postButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        view.addSubview(postButton)

        setupConstraints()
    }
    
    @objc func startDate() {
        endDatePicker.maximumDate = startDatePicker.date.addingTimeInterval(TimeInterval(86400))
        endDatePicker.minimumDate = startDatePicker.date
    }
    
    
    @objc func saveAction() {
        let name = nameTextField.text!
        let description = descriptionTextView.text!
        let location = locationTextField.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let start = dateFormatter.string(from: startDatePicker.date)
        let end = dateFormatter.string(from: endDatePicker.date)
        let is_public = publicSwitch.isOn
        
        if (!update) {
            delegate?.createEvent(name: name, description: description, start: start, end: end, location: location, is_public: is_public, hosting_fraternities: [ViewController.fraternity])
        } else {
            delegate?.updateEvent(id: event!.id, name: name, description: description, start: start, end: end, location: location, is_public: is_public, hosting_fraternities: [ViewController.fraternity])
        }
        navigationController?.popViewController(animated: true)
    }

    func setupConstraints() {
        let widthMultiplier: CGFloat = 0.75
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier)
        ])

        NSLayoutConstraint.activate([
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            descriptionTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier),
            descriptionTextView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
        ])

        
        NSLayoutConstraint.activate([
            locationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationTextField.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            locationTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier)
        ])
        
        NSLayoutConstraint.activate([
            startDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startDatePicker.topAnchor.constraint(equalTo: locationTextField.bottomAnchor, constant: 20),
            startDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier)
            ]
        )
        
        NSLayoutConstraint.activate([
            endDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endDatePicker.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 20),
            endDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier)
            ]
        )
        
        NSLayoutConstraint.activate([
            publicSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            publicSwitch.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 20),
            ]
        )
        
        NSLayoutConstraint.activate([
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postButton.topAnchor.constraint(equalTo: publicSwitch.bottomAnchor, constant: 20),
            postButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol EventDelegate: UIViewController {
    func createEvent(name: String, description: String, start: String, end: String, location: String, is_public: Bool, hosting_fraternities: [Fraternity])
    func updateEvent(id: Int, name: String, description: String, start: String, end: String, location: String, is_public: Bool, hosting_fraternities: [Fraternity])
}
