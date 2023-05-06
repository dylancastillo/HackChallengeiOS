//
//  InvitesViewController.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import UIKit

class InvitesViewController: UIViewController {

    static let NotificationDone = NSNotification.Name(rawValue: "Back")
    
    let invitesTableView = UITableView()
    let invitesReuseIdentifier = "invitesReuseIdentifier"
    
    let upcomingTableView = UITableView()
    let upcomingReuseIdentifier = "upcomingReuseIdentifier"
    
    let invitesLabel = UILabel()
    let upcomingLabel = UILabel()
    let addEventButton = UIBarButtonItem()
    let refreshInvitesControl = UIRefreshControl()
    let refreshUpcomingControl = UIRefreshControl()
    let publicButton = UIButton()
    let invitesButton = UIButton()

    var shownInvitesData: [Event] = []
    var shownUpcomingData: [Event] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Frat App"
        view.backgroundColor = .lightGray
        self.navigationController?.navigationBar.backgroundColor = .white
        invitesLabel.text = "INVITES"
        invitesLabel.font = .systemFont(ofSize: 20)
        invitesLabel.textColor = .white
        invitesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(invitesLabel)
        
        upcomingLabel.text = "UPCOMING"
        upcomingLabel.font = .systemFont(ofSize: 20)
        upcomingLabel.textColor = .white
        upcomingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(upcomingLabel)
        
        invitesTableView.translatesAutoresizingMaskIntoConstraints = false
        invitesTableView.delegate = self
        invitesTableView.dataSource = self
        invitesTableView.register(EventTableViewCell.self, forCellReuseIdentifier: invitesReuseIdentifier)
        view.addSubview(invitesTableView)
        
        upcomingTableView.translatesAutoresizingMaskIntoConstraints = false
        upcomingTableView.delegate = self
        upcomingTableView.dataSource = self
        upcomingTableView.register(EventTableViewCell.self, forCellReuseIdentifier: upcomingReuseIdentifier)
        view.addSubview(upcomingTableView)

        refreshInvitesControl.addTarget(self, action: #selector(refreshInvitesData), for: .valueChanged)
        refreshUpcomingControl.addTarget(self, action: #selector(refreshUpcomingData), for: .valueChanged)


        if #available(iOS 10.0, *) {
            invitesTableView.refreshControl = refreshInvitesControl
            upcomingTableView.refreshControl = refreshUpcomingControl
            
        } else {
            invitesTableView.addSubview(refreshInvitesControl)
            upcomingTableView.addSubview(refreshUpcomingControl)
        }
        addEventButton.image = UIImage(systemName: "plus")
        addEventButton.target = self
        addEventButton.action = #selector(pushCreateEventView)
        navigationItem.rightBarButtonItem = addEventButton
        
        publicButton.setImage(UIImage(systemName: "plus"), for: .normal)
        publicButton.setImage(UIImage(systemName: "minus"), for: .disabled)
        publicButton.setTitle("Public", for: .normal)
        publicButton.translatesAutoresizingMaskIntoConstraints = false
        publicButton.addTarget(self, action: #selector(pushInvitesView), for: .touchUpInside)

        view.addSubview(publicButton)
        
        invitesButton.setImage(UIImage(systemName: "minus"), for: .disabled)
        invitesButton.setImage(UIImage(systemName: "plus"), for: .normal)
        invitesButton.setTitle("Invites", for: .disabled)
        invitesButton.isEnabled = false
        invitesButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(invitesButton)

        getUpcomingData()
        getInvitesData()
        setupConstraints()
    }
    
    func getUpcomingData() {
        NetworkManager.shared.getUpcomingEvents(user_id: ViewController.user.id) { events in
            DispatchQueue.main.async {
                self.shownUpcomingData = events
                self.upcomingTableView.reloadData()
            }
        }
    }
    
    @objc func refreshUpcomingData() {
        NetworkManager.shared.getUpcomingEvents(user_id: ViewController.user.id) { events in
            DispatchQueue.main.async {
                self.shownUpcomingData = events
                self.upcomingTableView.reloadData()
                self.refreshUpcomingControl.endRefreshing()
            }
        }
    }
    
    func getInvitesData() {
        NetworkManager.shared.getInvitedEvents(user_id: ViewController.user.id) { events in
            DispatchQueue.main.async {
                self.shownInvitesData = events
                self.invitesTableView.reloadData()
            }
        }
    }
    
    @objc func refreshInvitesData() {
        NetworkManager.shared.getInvitedEvents(user_id: ViewController.user.id) { events in
            DispatchQueue.main.async {
                self.shownInvitesData = events
                self.invitesTableView.reloadData()
                self.refreshInvitesControl.endRefreshing()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .lightGray
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            invitesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            invitesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            upcomingLabel.topAnchor.constraint(equalTo: view.centerYAnchor),
            upcomingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            invitesTableView.topAnchor.constraint(equalTo: invitesLabel.bottomAnchor, constant: 10),
            invitesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            invitesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            invitesTableView.bottomAnchor.constraint(equalTo: upcomingLabel.topAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            upcomingTableView.topAnchor.constraint(equalTo: invitesTableView.bottomAnchor, constant: 45),
            upcomingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            upcomingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            upcomingTableView.bottomAnchor.constraint(equalTo: publicButton.topAnchor)
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
    
    @objc func pushInvitesView() {
        NotificationCenter.default.post(name: InvitesViewController.NotificationDone, object: nil)
    }
    
    @objc func pushCreateEventView() {
        navigationController?.pushViewController(CreateEventViewController(delegate: self, event: nil), animated: true)
    }

}

extension InvitesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == invitesTableView) {
            let event = shownInvitesData[indexPath.row]
            let vc = EventDetailsViewController(event: event)

            navigationController?.present(vc, animated: true)

        } else if (tableView == upcomingTableView) {
            let event = shownUpcomingData[indexPath.row]
            let vc = EventDetailsViewController(event: event)

            navigationController?.present(vc, animated: true)
        }
    }
    
}

extension InvitesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.invitesTableView) {
            return shownInvitesData.count

        } else if (tableView == self.upcomingTableView) {
            return shownUpcomingData.count
        }
        return -1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.invitesTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: invitesReuseIdentifier, for: indexPath) as! EventTableViewCell
            let eventObject = shownInvitesData[indexPath.row]
            cell.configure(eventObject: eventObject)
            return cell

        } else if (tableView == self.upcomingTableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: upcomingReuseIdentifier, for: indexPath) as! EventTableViewCell
            let eventObject = shownUpcomingData[indexPath.row]
            cell.configure(eventObject: eventObject)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions: [UIContextualAction] = []
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
                    (action, sourceView, completionHandler) in
            self.navigationController?.pushViewController(CreateEventViewController(delegate: self, event: self.shownUpcomingData[indexPath.row]), animated: true)
            completionHandler(true)
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
                    (action, sourceView, completionHandler) in
            let deletedEvent = self.shownUpcomingData[indexPath.row]
            self.shownUpcomingData.remove(at: indexPath.row)
            self.upcomingTableView.deleteRows(at: [indexPath], with: .fade)
            NetworkManager.shared.deleteEvent(id: deletedEvent.id) {event in
                self.refreshUpcomingData()
            }
            completionHandler(true)
        }
        let inviteAction = UIContextualAction(style: .normal, title: "Invite") {
                    (action, sourceView, completionHandler) in
            self.navigationController?.pushViewController(InvitesAllotmentViewController(delegate: self, event: self.shownUpcomingData[indexPath.row]), animated: true)
            completionHandler(true)
        }
        if (tableView == self.upcomingTableView) {
            actions.append(editAction)
            editAction.backgroundColor = UIColor.systemBlue
            actions.append(deleteAction)
            actions.append(inviteAction)
            inviteAction.backgroundColor = .magenta
        }
        
        let acceptAction = UIContextualAction(style: .destructive, title: "Accept") {
                    (action, sourceView, completionHandler) in
            let acceptedEvent = self.shownInvitesData[indexPath.row]
            self.shownInvitesData.remove(at: indexPath.row)
            self.invitesTableView.deleteRows(at: [indexPath], with: .fade)
            self.acceptInvite(event: acceptedEvent)
            completionHandler(true)
        }
        let declineAction = UIContextualAction(style: .destructive, title: "Decline") {
                    (action, sourceView, completionHandler) in
            let declinedEvent = self.shownInvitesData[indexPath.row]
            self.shownInvitesData.remove(at: indexPath.row)
            self.invitesTableView.deleteRows(at: [indexPath], with: .fade)
            self.rejectInvite(event: declinedEvent)
            completionHandler(true)
        }
        if (tableView == self.invitesTableView) {
            actions.append(acceptAction)
            acceptAction.backgroundColor = UIColor.systemGreen
            actions.append(declineAction)

        }
        
        return UISwipeActionsConfiguration(actions: actions)
    }
    
    func acceptInvite(event: Event) {
        NetworkManager.shared.acceptInvite(receiver_id: ViewController.user.id, event_id: event.id) { event in
            self.refreshInvitesData()
            self.refreshUpcomingData()
        }
    }
    
    func rejectInvite(event: Event) {
        NetworkManager.shared.rejectInvite(receiver_id: ViewController.user.id, event_id: event.id) { event in
            self.refreshInvitesData()
            self.refreshUpcomingData()
        }
    }
}

extension InvitesViewController: EventDelegate {
    func createEvent(name: String, description: String, start: String, end: String, location: String, is_public: Bool, hosting_fraternities: [Fraternity]) {
        NetworkManager.shared.createEvent(name: name, description: description, start: start, end: end, location: location, is_public: is_public, hosting_fraternities: hosting_fraternities) {event in
            if (!is_public) {
                NetworkManager.shared.createInvite(sender_id: ViewController.user.id, receiver_id: ViewController.user.id, event_id: event.id, fraternity_id: ViewController.fraternity.id) { event in
                    self.refreshInvitesData()
                }
            }
            self.refreshInvitesData()
        }
        
    }
    func updateEvent(id: Int, name: String, description: String, start: String, end: String, location: String, is_public: Bool, hosting_fraternities: [Fraternity]) {
        NetworkManager.shared.updateEvent(id: id, name: name, description: description, start: start, end: end, location: location, is_public: is_public, hosting_fraternities: hosting_fraternities) {event in
            if (!is_public) {
                NetworkManager.shared.createInvite(sender_id: ViewController.user.id, receiver_id: ViewController.user.id, event_id: event.id, fraternity_id: ViewController.fraternity.id) { event in
                    self.refreshInvitesData()
                    self.refreshUpcomingData()
                }
            }
            self.refreshInvitesData()
            self.refreshUpcomingData()
            }
        }

}

extension InvitesViewController: AllotmentDelegate {
    func modify_allotments(invite_allotments: [InviteAllotment]) {
    }
}
