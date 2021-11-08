//
//  EventsInteractor.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import Foundation

protocol EventsInteractorInput: AnyObject {
    func loadEvents()
}

protocol EventsInteractorOutput: AnyObject {
    func onFetch(events: [Event])
    func onFetch(error: Error)
}

final class EventsInteractor: EventsInteractorInput {
    
    weak var output: EventsInteractorOutput?
    
    private let network: EventsManagerProtocol

    init(network: EventsManagerProtocol) {
        self.network = network
    }
    
    func loadEvents() {
        network.fetchEvents { result in
            switch result {
            case .success(let events):
                self.output?.onFetch(events: events)
            case .failure(let error):
                self.output?.onFetch(error: error)
            }
        }
    }
    
}


