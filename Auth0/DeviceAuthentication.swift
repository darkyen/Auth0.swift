// DeviceAuthentication.swift
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

extension Auth0Authentication {
    public func startDeviceFlow(audience: String, scope: String) -> Request<DeviceResponse, AuthenticationError> {
        let deviceEndpoint = URL(string:"/oauth/device/code", relativeTo: self.url);
        
        let payload: [String: Any] = [
            "client_id": self.clientId,
            "audience": audience,
            "scope": scope
        ];
        
        return Request(session: session, url: deviceEndpoint, method: "POST", handle: authenticationObject, payload: payload, logger: self.logger, telemetry: self.telemetry)
    }
    
    public func checkDeviceActivation(deviceResponse: DeviceResponse) -> Request<Credentials, AuthenticationError>{
        let tokenEndpoint = URL(string: "/oauth/token", relativeTo: self.url);
        let payload: [String: Any] = [
            "client_id": self.clientId,
            "device_code": deviceResponse.deviceCode,
            "grant_type": "urn:ietf:params:oauth:grant-type:device_code"
        ]
                
        return Request(session: session, url: tokenEndpoint, method: "POST", handle: authenticationObject, payload: payload, logger: self.logger, telemetry: self.telemetry)
    }
}
