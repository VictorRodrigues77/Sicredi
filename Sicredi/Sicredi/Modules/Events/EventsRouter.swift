//
//  EventsRouter.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import UIKit

protocol EventsRouting: AnyObject {
    func showDetail(event: Event)
}

final class EventsRouter: Router, EventsRouting {
    private let builder: EventsDetailBuildable

    init(builder: EventsDetailBuildable) {
        self.builder = builder
    }
    
    func showDetail(event: Event) {
        let builder = builder.build(id: event.id)
        guard let controller = topNavController else { return }
        controller.pushViewController(builder, animated: true)
    }
    
}
