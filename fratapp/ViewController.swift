//
//  ViewController.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    static let NotificationDone = NSNotification.Name(rawValue: "Done")
    
    let eventTableView = UITableView()
    let eventReuseIdentifier = "eventReuseIdentifier"

    let addEventButton = UIBarButtonItem()
    let refreshControl = UIRefreshControl()
    let publicButton = UIButton()
    let invitesButton = UIButton()
    
    public static var user: User = User(id: 1, name: "dylan", net_id: "djc476", email: "djc476@cornell.edu")
    
    public static var fraternity: Fraternity = Fraternity(id: 1, name: "BTP", description: "We live in a house", members: [User(id: 1, name: "dylan", net_id: "djc476", email: "djc476@cornell.edu")], subscribers: [], events: [])

    var shownEventsData: [Event] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Frat App"
        view.backgroundColor = .lightGray
        eventTableView.translatesAutoresizingMaskIntoConstraints = false
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.register(EventTableViewCell.self, forCellReuseIdentifier: eventReuseIdentifier)
        view.addSubview(eventTableView)

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        if #available(iOS 10.0, *) {
            eventTableView.refreshControl = refreshControl
        } else {
            eventTableView.addSubview(refreshControl)
        }
        addEventButton.image = UIImage(systemName: "plus")
        addEventButton.target = self
        addEventButton.action = #selector(pushCreateEventView)
        navigationItem.rightBarButtonItem = addEventButton
        
        publicButton.setImage(UIImage(systemName: "minus"), for: .disabled)
        publicButton.setImage(UIImage(systemName: "plus"), for: .normal)
        publicButton.setTitle("Public", for: .disabled)
        publicButton.isEnabled = false
        publicButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(publicButton)
        
        invitesButton.setImage(UIImage(systemName: "minus"), for: .disabled)
        invitesButton.setImage(UIImage(systemName: "plus"), for: .normal)
        invitesButton.setTitle("Invites", for: .normal)
        invitesButton.translatesAutoresizingMaskIntoConstraints = false
        invitesButton.addTarget(self, action: #selector(pushInvitesView), for: .touchUpInside)

        view.addSubview(invitesButton)

        getData()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .lightGray
        #imageLiteral(resourceName: "simulator_screenshot_A9514EBB-AED0-4A7A-8C7D-00B63EC7D7B0.png")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            eventTableView.topAnchor.constraint(equalTo: view.topAnchor),
            eventTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventTableView.bottomAnchor.constraint(equalTo: publicButton.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            publicButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            publicButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            publicButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            publicButton.trailingAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            invitesButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            invitesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            invitesButton.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            invitesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    func getData() {
//        shownEventsData = [Event(id: 1, name: "First rush event", description: "This is the first rush event", start: Date(), end: Date().addingTimeInterval(TimeInterval(6000)), location: "Duffield", is_public: true, hosting_fraternities: ["Appdev"])]
        NetworkManager.shared.getAllEvents { events in
            DispatchQueue.main.async {
                self.shownEventsData = events
                self.eventTableView.reloadData()
            }
        }
    }
    
    @objc func refreshData() {
        NetworkManager.shared.getAllEvents { messages in
            DispatchQueue.main.async {
                self.shownEventsData = messages
                self.eventTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func pushInvitesView() {
        NotificationCenter.default.post(name: ViewController.NotificationDone, object: nil)
    }
    
    @objc func pushCreateEventView() {
        navigationController?.pushViewController(CreateEventViewController(delegate: self, event: nil), animated: true)
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = shownEventsData[indexPath.row]
        let vc = EventDetailsViewController(event: event)

        navigationController?.present(vc, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownEventsData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: eventReuseIdentifier, for: indexPath) as! EventTableViewCell
        let eventObject = shownEventsData[indexPath.row]
        cell.configure(eventObject: eventObject)
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
                    (action, sourceView, completionHandler) in
            self.navigationController?.pushViewController(CreateEventViewController(delegate: self, event: self.shownEventsData[indexPath.row]), animated: true)
            completionHandler(true)
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
                    (action, sourceView, completionHandler) in
            let deletedEvent = self.shownEventsData[indexPath.row]
            self.shownEventsData.remove(at: indexPath.row)
            self.eventTableView.deleteRows(at: [indexPath], with: .fade)
            NetworkManager.shared.deleteEvent(id: deletedEvent.id) {event in
                self.refreshData()
            }
            completionHandler(true)
        }
        editAction.backgroundColor = UIColor.systemBlue
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
}

extension ViewController: EventDelegate {

    func createEvent(name: String, description: String, start: String, end: String, location: String, is_public: Bool, hosting_fraternities: [Fraternity]) {
        NetworkManager.shared.createEvent(name: name, description: description, start: start, end: end, location: location, is_public: is_public, hosting_fraternities: hosting_fraternities) {event in
            if (!is_public) {
                NetworkManager.shared.createInvite(sender_id: ViewController.user.id, receiver_id: ViewController.user.id, event_id: event.id, fraternity_id: ViewController.fraternity.id) { event in
                    self.refreshData()
                }
            } else {
                self.refreshData()
            }
        }
        
    }
    func updateEvent(id: Int, name: String, description: String, start: String, end: String, location: String, is_public: Bool, hosting_fraternities: [Fraternity]) {
        NetworkManager.shared.updateEvent(id: id, name: name, description: description, start: start, end: end, location: location, is_public: is_public, hosting_fraternities: hosting_fraternities) {event in
            if (!is_public) {
                NetworkManager.shared.createInvite(sender_id: ViewController.user.id, receiver_id: ViewController.user.id, event_id: event.id, fraternity_id: ViewController.fraternity.id) { event in
                    self.refreshData()
                }
            } else {
                self.refreshData()
            }
            }
        }
    

}
