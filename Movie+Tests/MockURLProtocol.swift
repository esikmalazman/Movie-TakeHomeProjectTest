//
//  MockURLProtocol.swift
//  Movie+Tests
//
//  Created by Ikmal Azman on 26/06/2023.
//

import Foundation
import XCTest

final class MockURLProtocol : URLProtocol {
    /// 1. Handler to test the request and return mock response.
    static var requestHandler : ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    /// To check if this protocol can handle give request
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    /// Return the canonical version of the request but most of the time we will pass the orignal request.
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    /// Place where we create the mock response as per test case and send it to URLProtocolClient
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set", file: #file, line: #line)
            return
        }
        
        do {
            /// 2. Call handler with received request and capture the tuple of response and data.
            let (response, data) = try handler(request)
            
            /// 3. Send received response to the client.
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            /// 4. Send received data to the client.
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            /// 5. Notify request has been finished.
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            /// 6. Notify received error
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    /// Method active when request get cancel
    override func stopLoading() {}
}
