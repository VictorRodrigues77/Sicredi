//
//  EventsPresenter.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import Foundation

protocol EventsPresenterInput: AnyObject {
    var eventsCount: Int { get }
    
    func event(at index: Int) -> Event?
    func selectEvent(at index: Int)
    func loadEvents()
}

protocol EventsPresenterOutput: AnyObject {
    func showProgress()
    func hideProgress()
    func onFetchEvents()
    func onFetchEvents(error: String)
}

final class EventsPresenter: EventsPresenterInput {
    
    weak var output: EventsPresenterOutput?

    private var interactor: EventsInteractorInput
    private let router: EventsRouting

    init(interactor: EventsInteractorInput,
         router: EventsRouting) {
        
        self.interactor = interactor
        self.router = router
    }
    
    private(set) var events: [Event]? {
        didSet {
            self.output?.onFetchEvents()
        }
    }
    
    var eventsCount: Int {
        return events?.count ?? 0
    }
    
    func event(at index: Int) -> Event? {
        return events?[index] ?? nil
    }
    
    func selectEvent(at index: Int) {
        guard let events = events else { return }
        router.showDetail(event: events[index])
    }
    
    func loadEvents() {
        interactor.loadEvents()
    }
    
}

extension EventsPresenter: EventsInteractorOutput {
    func onFetch(events: [Event]) {
        self.output?.showProgress()
        DispatchQueue.main.async {
            self.output?.hideProgress()
            self.events = events
            self.output?.onFetchEvents()
        }
    }
    
    func onFetch(error: Error) {
        self.output?.onFetchEvents(error: error.localizedDescription)
    }
}


