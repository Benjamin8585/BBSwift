//
//  Request.swift
//  BBSwift
//
//  Created by Benjamin Bourasseau on 18/06/2020.
//

import Foundation
import Combine
#if !os(macOS)
import SwiftUI

extension APIRoutes: URLRequestConvertible {
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        var urlRequest = URLRequest(url: self.baseUrl)
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

extension APIRoutes: Requestable {
    func request<T>(type: Array<T>.Type) -> AnyPublisher<[T], APIError> where T: JSONContructible {
        let request = try! self.asURLRequest()
        self.logRequest(request: request)
        let startDate = Date()
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                try self.handleTryMap(response: response, data: data, requestStartsAt: startDate)
                let jsonArray = try data.toJsonArray()
                return try jsonArray.map { try T.init(json: $0) }
            }
            .mapError { error in return self.handleMapError(error: error) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func request<T>(type: T.Type) -> AnyPublisher<T, APIError> where T: JSONContructible {
        let request = try! self.asURLRequest()
         logRequest(request: request)
         let startDate = Date()
         return URLSession.DataTaskPublisher(request: request, session: .shared)
             .tryMap { data, response in
                 try self.handleTryMap(response: response, data: data, requestStartsAt: startDate)
                 let json: JSON = try data.toJson()
                 return try T.init(json: json)
             }
             .mapError { error in return self.handleMapError(error: error) }
             .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher()
    }
    
    func uploadFile<T>(type: T.Type, paramName: String, fileName: String, contentType: String, fileData: Data) -> AnyPublisher<T, APIError> where T: JSONContructible {
        let url = self.baseUrl.toUrl()!
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
            let json: JSON = try data.toJson()
            return try T.init(json: json)
        }
        .mapError { error in return self.handleMapError(error: error) }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

extension APIRoutes {

    func checkErrors(response: URLResponse?, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            guard let json: JSON = try? data.toJson() else {
                throw APIError.encodingFailed(response: response, data: data)
            }
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                switch statusCode {
                case 502:
                    throw APIError.badGateway
                case 500:
                    throw APIError.internalServerError
                case 404:
                    throw APIError.notFound
                case 429:
                    throw APIError.tooManyRequests
                default:
                    throw APIError.unexpected
                }
            } else {
                throw APIError.unexpected
            }
        }

    }

    func handleMapError(error: Error) -> APIError {
        if let error = error as? APIError {
            return error
        } else {
            return APIError.custom("API_ERROR", 500, error.localizedDescription)
        }
    }

    func handleTryMap(response: URLResponse?, data: Data, requestStartsAt: Date) throws {
        self.logResponse(response: response, data: data, requestStartsAt: requestStartsAt)
        try self.checkErrors(response: response, data: data)
    }
    
    /// Log request. This is strongly recommendend to  set printData to false is data is big (ex: file...)
    func logRequest(request: URLRequest, printData: Bool = true) {
        if Config.logRequestsMode == .all || Config.logRequestsMode == .requestOnly {
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
        if Config.logRequestsMode == .all || Config.logRequestsMode == .responseOnly {
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
#endif
