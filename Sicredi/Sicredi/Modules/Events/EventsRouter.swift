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
//    private let builder: JokeBuildable
//
//    init(builder: JokeBuildable) {
//        self.builder = builder
//    }
    
    func showDetail(event: Event) {
        print(event)
    }
    
//    func showJoke(term: String) {
//        let jokeBuilder = builder.build(term: term)
//        guard let controller = topNavController else { return }
//        controller.pushViewController(jokeBuilder, animated: true)
//    }
}


