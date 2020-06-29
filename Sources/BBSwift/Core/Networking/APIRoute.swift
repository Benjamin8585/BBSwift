//
//  APIRoute.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

public protocol APIRouteRequestable {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: JSON? { get }
    var headers: [String: String] { get }
    var baseUrl: String { get }
}
