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
    case encodingFailed(response: URLResponse?, data: Data)
    case badGateway, internalServerError, tooManyRequests, notFound, tokenExpired
    case networkCallCancelled
    
}
