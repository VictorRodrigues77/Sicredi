//
//  EventsDetailInteractor.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import Foundation

protocol EventsDetailInteractorInput: AnyObject {
    func loadEvent()
    func postCheckIn(name: String, email: String)
}

protocol EventsDetailInteractorOutput: AnyObject {
    func onFetch(event: Event)
    func onFetch(error: Error)
    func onCheckIn()
    func onCheckIn(error: Error)
}

final class EventsDetailInteractor: EventsDetailInteractorInput {
    
    weak var output: EventsDetailInteractorOutput?
    
    private let id: String
    private let network: EventsManagerProtocol

    init(id: String,
         network: EventsManagerProtocol) {
        
        self.id = id
        self.network = network
    }
    
    func loadEvent() {
        network.fetchEventsDetail(id: id) { result in
            switch result {
            case .success(let event):
                self.output?.onFetch(event: event)
            case .failure(let error):
                self.output?.onFetch(error: error)
            }
        }
    }
    
    func postCheckIn(name: String, email: String) {
        network.postCheckin(eventId: id, name: name, email: email) { result in
            switch result {
            case .success(_):
                self.output?.onCheckIn()
            case .failure(let error):
                self.output?.onFetch(error: error)
            }
        }
    }
    
}



