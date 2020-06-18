//
//  APIRoute.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation

struct APIRoutes: APIRoute {
    
    var path: String = "OK"
    
    var method: HTTPMethod = .get
    
    var parameters: JSON? = nil
    
    var headers: [String : String] = [:]
    
    var baseUrl: String = "http://google.fr"
    
    
}

public protocol APIRoute {
    
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: JSON? { get }
    var headers: [String: String] { get }
    var baseUrl: String { get }
}
