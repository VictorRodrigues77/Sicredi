//
//  EventsApi.swift
//  Sicredi
//
//  Created by Victor Rodrigues on 08/11/21.
//

import Moya

public enum EventsApi {
    case events
    case eventsBy(id: String)
    case checkIn(eventId: String, name: String, email: String)
}

extension EventsApi: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: "http://5f5a8f24d44d640016169133.mockapi.io") else { fatalError() }
        return url
    }
    
    public var path: String {
        switch self {
        case .events:
            return "/api/events"
        case .eventsBy(let id):
            return "/api/events/\(id)"
        case .checkIn:
            return "/api/checkin"
        }
    }
    
    public var method: Method {
        switch self {
        case .events, .eventsBy:
            return .get
        case .checkIn:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .events, .eventsBy:
            return .requestPlain
        case .checkIn(let eventId, let name, let email):
            return .requestParameters(
                parameters: [
                    "eventId": eventId,
                    "name": name,
                    "email": email
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}

