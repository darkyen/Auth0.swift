// DeviceResponse.swift
//
// Copyright (c) 2019 Auth0 (http://auth0.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

class DeviceResponse: NSObject, JSONObjectPayload, NSSecureCoding {
    public let deviceCode: String!
    public let userCode: String!
    public let verificationUri: String!
    public let verificationUriComplete: String!
    public let expiresIn: Date!;
    
    public init(
        deviceCode: String,
        userCode: String,
        verificationUri: String,
        verificationUriComplete: String,
        expiresIn: Date
    ) {
        self.deviceCode = deviceCode;
        self.userCode = userCode;
        self.verificationUri = verificationUri;
        self.verificationUriComplete = verificationUriComplete;
        self.expiresIn = expiresIn;
    }
    
    
    convenience required public init(json: [String: Any]) {
        var expiresIn: Date?
        switch json["expires_in"] {
        case let string as String:
            guard let double = Double(string) else { break }
            expiresIn = Date(timeIntervalSinceNow: double)
        case let int as Int:
            expiresIn = Date(timeIntervalSinceNow: Double(int))
        case let double as Double:
            expiresIn = Date(timeIntervalSinceNow: double)
        default:
            expiresIn = nil
        }
            
        self.init(
               deviceCode: json["device_code"] as! String,
               userCode: json["user_code"] as! String,
               verificationUri: json["verification_uri"] as! String,
               verificationUriComplete: json["verification_uri_complete"] as! String,
               expiresIn: expiresIn!
        )
    }
    
    // MARK: - NSSecureCoding
    convenience required public init?(coder aDecoder: NSCoder) {
        let deviceCode = aDecoder.decodeObject(forKey: "deviceCode") as! String
        let userCode = aDecoder.decodeObject(forKey: "userCode") as! String
        let verificationUri = aDecoder.decodeObject(forKey: "verificationUri") as! String
        let verificationUriComplete = aDecoder.decodeObject(forKey: "verificationUriComplete") as! String
        let expiresIn = aDecoder.decodeObject(forKey: "expiresIn") as! Date

        self.init(
            deviceCode: deviceCode,
            userCode: userCode,
            verificationUri: verificationUri,
            verificationUriComplete: verificationUriComplete,
            expiresIn: expiresIn
        )
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.deviceCode, forKey: "deviceCode")
        aCoder.encode(self.userCode, forKey: "userCode")
        aCoder.encode(self.verificationUri, forKey: "verificationUri")
        aCoder.encode(self.verificationUriComplete, forKey: "verificationUriComplete")
        aCoder.encode(self.expiresIn, forKey: "expiresIn")
    }

    public static var supportsSecureCoding: Bool = true
}
