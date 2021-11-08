//
//  EventsDetailPresenter.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import Foundation

protocol EventsDetailPresenterInput: AnyObject {
    func loadEvent()
}

protocol EventsDetailPresenterOutput: AnyObject {
    func showProgress()
    func hideProgress()
    func onFetchEvent(event: Event)
    func onFetchEvent(error: String)
}

final class EventsDetailPresenter: EventsDetailPresenterInput {
    
    weak var output: EventsDetailPresenterOutput?

    private var interactor: EventsDetailInteractorInput

    init(interactor: EventsDetailInteractorInput) {
        self.interactor = interactor
    }
    
    func loadEvent() {
        interactor.loadEvent()
    }
    
}

extension EventsDetailPresenter: EventsDetailInteractorOutput {
    func onFetch(event: Event) {
        self.output?.showProgress()
        DispatchQueue.main.async {
            self.output?.hideProgress()
            self.output?.onFetchEvent(event: event)
        }
    }
    
    func onFetch(error: Error) {
        self.output?.onFetchEvent(error: error.localizedDescription)
    }
}



