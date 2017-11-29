//
//  URLProtocol.swift
//  AlamofireCodable_Example
//
//  Created by Steve on 24/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

class AURLProtocol: URLProtocol {
    
static var session: URLSession!

struct PropertyKeys {
    static let handledByForwarderURLProtocol = "HandledByProxyURLProtocol"
    }

var activeTask: URLSessionTask?

override class func canInit(with request: URLRequest) -> Bool {
    return true
    }

override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
    }

override func startLoading() {
    super.startLoading()
    }

override func stopLoading() {
    activeTask?.cancel()
    }
    
}
