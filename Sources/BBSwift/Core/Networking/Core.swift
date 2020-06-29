//
//  Core.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import Combine

public typealias JSON = [String: Any]

public protocol JSONContructible {
    init(json: JSON) throws
}

/// Use this class if you don't want to parse the response
public struct DontParse: JSONContructible {
    
    let json: JSON
    
    public init(json: JSON) throws {
        self.json = json
    }
}

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    public static let connect = HTTPMethod(rawValue: "CONNECT")
    public static let delete = HTTPMethod(rawValue: "DELETE")
    public static let get = HTTPMethod(rawValue: "GET")
    public static let head = HTTPMethod(rawValue: "HEAD")
    public static let options = HTTPMethod(rawValue: "OPTIONS")
    public static let patch = HTTPMethod(rawValue: "PATCH")
    public static let post = HTTPMethod(rawValue: "POST")
    public static let put = HTTPMethod(rawValue: "PUT")
    public static let trace = HTTPMethod(rawValue: "TRACE")
    public let rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public protocol Requestable {
    @available(OSX 10.15, *)
    func request<T>(type: Array<T>.Type) -> AnyPublisher<[T], APIError> where T: JSONContructible
    @available(OSX 10.15, *)
    func request<T>(type: T.Type) -> AnyPublisher<T, APIError> where T: JSONContructible
}

public protocol APIRouteAssociable {
    static func getAssociatedRoute() -> APIRoute
}

public protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

public enum APIError: Error, Equatable {

    case unexpected
    case encodingFailed
    case decodingFailed(response: URLResponse?, data: Data)
    case badGateway, internalServerError, tooManyRequests, notFound, tokenExpired
    case networkCallCancelled
    case fromServer(String, Int, String)
    case custom(error: Error)
    case json
    
    var value: Int {
        switch self {
        case .unexpected:
            return 0
        case .encodingFailed:
            return 1
        case .decodingFailed:
            return 2
        case .networkCallCancelled:
            return 3
        case .json:
            return 4
        case .tokenExpired:
            return 401
        case .notFound:
            return 404
        case .tooManyRequests:
                return 429
        case .internalServerError:
            return 500
            case .badGateway:
                return 502
        case .fromServer(_, let code, _):
            return code
        case .custom(let error):
            return Int(error.localizedDescription) ?? -1
        }
    }
    
    public static func ==(lhs: APIError, hrs: APIError) -> Bool {
        return lhs.value == hrs.value
    }
    
}