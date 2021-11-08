//
//  EventsBuilder.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import UIKit

protocol EventsBuildable: AnyObject {
    func build() -> EventsViewController
}

final class EventsBuilder: EventsBuildable {
    func build() -> EventsViewController {
        let interactor = EventsInteractor(
            network: EventsManager()
        )
        
        let router = EventsRouter(
            builder: EventsDetailBuilder()
        )
        
        let presenter = EventsPresenter(
            interactor: interactor,
            router: router
        )
        
        let controller = UIStoryboard(name: "Events", bundle: nil)
            .instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
        
        controller.presenter = presenter
        presenter.output = controller
        interactor.output = presenter
        
        return controller
    }
}

