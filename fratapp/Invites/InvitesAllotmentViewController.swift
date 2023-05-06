//
//  InvitesAllotmentViewController.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import UIKit

class InvitesAllotmentViewController: UIViewController {

    let allotmentTableView = UITableView()
    let allotmentReuseIdentifier = "allotmentReuseIdentifier"

    let saveButton = UIBarButtonItem()
    let refreshControl = UIRefreshControl()

    var shownAllotmentData: [InviteAllotment] = []
    
    weak var delegate: AllotmentDelegate?

    init(delegate: AllotmentDelegate, event: Event) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        inviteAllotmentsFromEvent(event: event)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inviteAllotmentsFromEvent(event: Event) {
        getDummyData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Frat App"
        view.backgroundColor = .lightGray
        allotmentTableView.translatesAutoresizingMaskIntoConstraints = false
        allotmentTableView.dataSource = self
        allotmentTableView.register(InvitesAllotmentTableViewCell.self, forCellReuseIdentifier: allotmentReuseIdentifier)
        view.addSubview(allotmentTableView)

        refreshControl.addTarget(self, action: #selector(refreshDummyData), for: .valueChanged)

        if #available(iOS 10.0, *) {
            allotmentTableView.refreshControl = refreshControl
        } else {
            allotmentTableView.addSubview(refreshControl)
        }
        saveButton.title = "Save"
        saveButton.target = self
        saveButton.action = #selector(popView)
        navigationItem.rightBarButtonItem = saveButton
        getDummyData()
        setupConstraints()
    }
    
    @objc func popView() {
        delegate?.modify_allotments(invite_allotments: shownAllotmentData)
        navigationController?.popViewController(animated: true)
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
            allotmentTableView.topAnchor.constraint(equalTo: view.topAnchor),
            allotmentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            allotmentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            allotmentTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        
    }
    
    func getDummyData() {
        shownAllotmentData = [InviteAllotment(user_id: 1, user_name: "Dylan", event_id: 1, num_invites: 0)]
    }
    
    @objc func refreshDummyData() {
        shownAllotmentData = [InviteAllotment(user_id: 1, user_name: "Dylan", event_id: 1, num_invites: 0)]
        self.allotmentTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

extension InvitesAllotmentViewController: UITableViewDataSource, UITextFieldDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownAllotmentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: allotmentReuseIdentifier, for: indexPath) as! InvitesAllotmentTableViewCell
        let inviteAllotmentObject = shownAllotmentData[indexPath.row]
        cell.configure(inviteAllotment: inviteAllotmentObject)
        cell.numberTextField.tag = indexPath.row
        cell.numberTextField.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func textFieldDidEndEditing (_ textField: UITextField) {
        let idx = NSIndexPath(row: textField.tag, section: 0)
        if allotmentTableView.cellForRow(at: idx as IndexPath) is InvitesAllotmentTableViewCell {
            if textField.text == "" {
                shownAllotmentData[textField.tag].num_invites = 0
            } else {
                shownAllotmentData[textField.tag].num_invites = Int(textField.text!)!
            }
        }
    }
}

protocol AllotmentDelegate: UIViewController {
    func modify_allotments(invite_allotments: [InviteAllotment])
}
