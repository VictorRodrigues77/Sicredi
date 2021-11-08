//
//  EventsDetailViewController.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import UIKit
import MBProgressHUD

class EventsDetailViewController: UIViewController {
    
    @IBOutlet private weak var eventsDetailImageView: UIImageView!
    @IBOutlet private weak var eventsDetailTitleLabel: UILabel!
    @IBOutlet private weak var eventsDetailDescriptionLabel: UILabel!
    
    var presenter: EventsDetailPresenterInput?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigation()
        presenter?.loadEvent()
    }

    @IBAction private func eventsDetailCheckIn(_ sender: UIButton) {
        let alert = UIAlertController(title: "CheckIn", message: "Preencha para fazer checkIn", preferredStyle: .alert)
        
            alert.addTextField { (name) in
                name.text = ""
                name.placeholder = "Nome:"
            }
        
            alert.addTextField { (email) in
                email.text = ""
                email.placeholder = "Email:"
            }
        
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let nameField = alert?.textFields![0]
                let emailField = alert?.textFields![1]

                let name = nameField?.text
                let email = emailField?.text
                
                if name == "" || email == "" {
                    let correctAlert = UIAlertController(
                        title: "Preencha corretamente",
                        message: "Preencha os campos corretamente",
                        preferredStyle: .alert
                    )
                    correctAlert.addAction(
                        UIAlertAction(
                            title: "Ok",
                            style: .default,
                            handler: nil
                        )
                    )
                    self.present(correctAlert, animated: true, completion: nil)
                } else {
                    self.presenter?.postCheckIn(name: name!, email: email!)
                }
            }))
            self.present(alert, animated: true, completion: nil)
    }
}

extension EventsDetailViewController {
    private func prepareNavigation() {
        title = "Evento"
    }
}

extension EventsDetailViewController: EventsDetailPresenterOutput {
    func showProgress() {
        MBProgressHUD
            .showAdded(to: self.view, animated: true)
    }
    
    func hideProgress() {
        MBProgressHUD
            .hide(for: self.view, animated: true)
    }
    
    func onFetchEvent(event: Event) {
        eventsDetailImageView.downloaded(from: event.image) { result in
            switch result {
            case .success(let image):
                self.eventsDetailImageView.image = image
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    self?.eventsDetailImageView.isHidden = true
                }
            }
        }
        eventsDetailTitleLabel.text = event.title
        eventsDetailDescriptionLabel.text = event.description
    }
    
    func onFetchEvent(error: String) {
        let alert = UIAlertController(title: "Erro", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func onCheckIn() {
        let alert = UIAlertController(title: "Sucesso CheckIn", message: "Parabens você fez checkIn", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func onCheckIn(error: String) {
        let alert = UIAlertController(title: "Erro", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
}
