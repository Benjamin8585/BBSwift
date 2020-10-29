//
//  Request.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import Combine
import SwiftUI

public protocol JSONDecodable: Decodable {
    
}

public extension JSONDecodable {
    init(json: JSON) throws {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: jsonData)
    }
}

public struct ServerError: JSONDecodable, Decodable {
    
    var name: String
    var message: String
    var status: Int
    
    private enum CodingKeys: String, CodingKey {
        case name, message, status
    }
    
    init(data: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(ServerError.self, from: data)
    }
}

public extension APIRouteRequestable {
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: (self.baseUrl + self.path).toUrl()!)
       // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        // Parameters
        if let parameters = parameters {
           do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
           } catch {
                throw APIError.encodingFailed
           }
        }
        return urlRequest
    }
}

public extension APIRouteRequestable {
    
    /// Request the server and return array of objects. You need to provide the type of the object inside array response
    func request<T>(type: Array<T>.Type) -> AnyPublisher<[T], APIError> where T: JSONConstructible {
        let request = try! self.asURLRequest()
        self.logRequest(request: request)
        let startDate = Date()
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                try self.handleTryMap(response: response, data: data, requestStartsAt: startDate)
                guard let jsonArray: [JSON] = try data.toJsonArray() else { throw APIError.json }
                return try jsonArray.map { try T.init(json: $0) }
            }
            .mapError { error in return self.handleMapError(error: error) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    /// Request the server and return an object. You need to provide the type of the object
    func request<T>(type: T.Type) -> AnyPublisher<T, APIError> where T: JSONConstructible {
        let request = try! self.asURLRequest()
         logRequest(request: request)
         let startDate = Date()
         return URLSession.DataTaskPublisher(request: request, session: .shared)
             .tryMap { data, response in
                 try self.handleTryMap(response: response, data: data, requestStartsAt: startDate)
                 guard let json: JSON = try data.toJson() else { throw APIError.json }
                 return try T.init(json: json)
             }
             .mapError { error in return self.handleMapError(error: error) }
             .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher()
    }
    
    func uploadFile<T>(type: T.Type, paramName: String, fileName: String, contentType: String, fileData: Data) -> AnyPublisher<T, APIError> where T: JSONConstructible {
        let url = (self.baseUrl + self.path).toUrl()!
        let boundary = UUID().uuidString
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.allHTTPHeaderFields = self.headers
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type:\(contentType)\r\n\r\n".data(using: .utf8)!)
        data.append(fileData)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        urlRequest.httpBody = data
        let startDate = Date()
        self.logRequest(request: urlRequest, printData: false)
        return URLSession.DataTaskPublisher(request: urlRequest, session: .shared)
        .tryMap { data, response in
            try self.handleTryMap(response: response, data: data, requestStartsAt: startDate)
            guard let json: JSON = try data.toJson() else { throw APIError.json }
            return try T.init(json: json)
        }
        .mapError { error in return self.handleMapError(error: error) }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

public extension APIRouteRequestable {
    
    private func errorForResponse(response: URLResponse?, data: Data) -> APIError {
        if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            switch statusCode {
            case 502:
                return APIError.badGateway
            case 500:
                return APIError.internalServerError
            case 404:
                return APIError.notFound
            case 429:
                return APIError.tooManyRequests
            default:
                return APIError.decodingFailed(response: response, data: data)
            }
        } else {
            return APIError.unexpected
        }
    }

    func checkErrors(response: URLResponse?, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            if let error = try? ServerError(data: data) {
                throw APIError.fromServer(error)
            } else {
                throw self.errorForResponse(response: response, data: data)
            }
        }

    }

    func handleMapError(error: Error) -> APIError {
        if let error = error as? APIError {
            return error
        } else {
            return APIError.custom(error: error)
        }
    }

    func handleTryMap(response: URLResponse?, data: Data, requestStartsAt: Date) throws {
        self.logResponse(response: response, data: data, requestStartsAt: requestStartsAt)
        try self.checkErrors(response: response, data: data)
    }
    
    /// Log request. This is strongly recommendend to  set printData to false is data is big (ex: file...)
    func logRequest(request: URLRequest, printData: Bool = true) {
        let mode = BBSwift.instance.options.logRequestMode
        if mode == .all || mode == .requestOnly {
            var requestLog = """
            ⚡️⚡️ Request: \(request.httpMethod ?? "No HTTP method") \(request.url?.absoluteString ?? "No URL")
            ⚡️⚡️⚡️⚡️ Headers: \(request.allHTTPHeaderFields ?? ["": ""])
            ⚡️⚡️⚡️⚡️ Cache Policy: \(request.cachePolicy)
            """
            if printData {
                if let httpBody = request.httpBody {
                    requestLog += "\n⚡️⚡️⚡️⚡️ HTTP Body: \(String(decoding: httpBody, as: UTF8.self))"
                }
            }
            print(requestLog)
        }
    }

    func logResponse(response: URLResponse?, data: Data?, requestStartsAt: Date) {
        let mode = BBSwift.instance.options.logRequestMode
        if mode == .all || mode == .responseOnly {
            if let response = response as? HTTPURLResponse {
                let executionTime = Date().timeIntervalSince(requestStartsAt)
                var responseLog = """
                ⚡️⚡️ Response: \(response.statusCode) \(response.url?.absoluteString ?? "No URL or no response")
                ⚡️⚡️⚡️⚡️ Headers: \(response.allHeaderFields.map { String("\($0.key): \($0.value)") })
                ⚡️⚡️⚡️⚡️ Response time: \(Double(round(1000 * executionTime * 1000)/1000)) ms
                """
                if let data = data?.prettyPrinted {
                    responseLog += "\n⚡️⚡️⚡️⚡️ Data: \(data)"
                }
                print(responseLog)
            } else {
                print("⚡️⚡️ Response is nil or not convertible to HTTPUrlResponse")
            }
        }
    }
}
