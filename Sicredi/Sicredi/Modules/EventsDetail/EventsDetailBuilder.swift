//
//  EventsDetailBuilder.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import UIKit

protocol EventsDetailBuildable: AnyObject {
    func build(id: String) -> EventsDetailViewController
}

final class EventsDetailBuilder: EventsDetailBuildable {
    func build(id: String) -> EventsDetailViewController {
        let interactor = EventsDetailInteractor(
            id: id,
            network: EventsManager()
        )
        
        let presenter = EventsDetailPresenter(
            interactor: interactor
        )
        
        let controller = UIStoryboard(name: "EventsDetail", bundle: nil)
            .instantiateViewController(withIdentifier: "EventsDetailViewController") as! EventsDetailViewController
        
        controller.presenter = presenter
        presenter.output = controller
        interactor.output = presenter
        
        return controller
    }
}


