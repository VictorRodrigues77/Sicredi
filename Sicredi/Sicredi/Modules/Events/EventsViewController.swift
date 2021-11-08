//
//  EventsViewController.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import UIKit
import MBProgressHUD

class EventsViewController: UIViewController {
    
    @IBOutlet private weak var eventsTableView: UITableView!
    @IBOutlet private weak var eventsErrorLabel: UILabel!
    
    var presenter: EventsPresenterInput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.loadEvents()
    }

}

extension EventsViewController {
    private func prepareTableView() {
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
    }
    
    private func prepareNavigation() {
        title = "Eventos"
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.eventsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCell", for: indexPath)
        let event = presenter?.event(at: indexPath.row)
        cell.textLabel?.text = event?.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectEvent(at: indexPath.row)
    }
}

extension EventsViewController: EventsPresenterOutput {
    func showProgress() {
        MBProgressHUD
            .showAdded(to: self.view, animated: true)
    }
    
    func hideProgress() {
        MBProgressHUD
            .hide(for: self.view, animated: true)
    }
    
    func onFetchEvents() {
        self.eventsTableView.isHidden = false
        self.eventsTableView.reloadData()
    }
    
    func onFetchEvents(error: String) {
        self.eventsTableView.isHidden = true
        self.eventsErrorLabel.text = error
    }
}
