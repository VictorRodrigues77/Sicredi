//
//  EventsManager.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import Moya

protocol EventsManagerProtocol {
    var provider: MoyaProvider<EventsApi> { get }
    
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void)
    func fetchEventsDetail(id: String, completion: @escaping (Result<Event, Error>) -> Void)
    func postCheckin(eventId: String, name: String, email: String, completion: @escaping (Result<Void, Error>) -> Void)
}

class EventsManager: EventsManagerProtocol {
    var provider = MoyaProvider<EventsApi>(plugins: [NetworkLoggerPlugin()])
    
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        request(target: .events, completion: completion)
    }
    
    func fetchEventsDetail(id: String, completion: @escaping (Result<Event, Error>) -> Void) {
        request(target: .eventsBy(id: id), completion: completion)
    }
    
    func postCheckin(eventId: String, name: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        request(target: .checkIn(eventId: eventId, name: name, email: email), completion: completion)
    }
}

private extension EventsManager {
    private func request(target: EventsApi, completion: @escaping (Result<Void, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case .success(_):
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func request<T: Decodable>(target: EventsApi, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

