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
                self.eventsDetailImageView.isHidden = true
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
}
