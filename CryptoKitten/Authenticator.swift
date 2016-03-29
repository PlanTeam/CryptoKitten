//
//  MAC.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 03/09/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//

import C7

/**
 *  Message Authentication
 */
public enum Authenticator {
    
    public enum Error: ErrorProtocol {
        case AuthenticateError
    }
    
    /**
     Poly1305
     
     - parameter key: 256-bit key
     */
    case HMAC(key: [Byte], variant: CryptoKitten.HMAC.Variant)
    
    /**
     Generates an authenticator for message using a one-time key and returns the 16-byte result
     
     - returns: 16-byte message authentication code
     */
    public func authenticate(message: [Byte]) throws -> [Byte] {
        switch (self) {
        case .HMAC(let key, let variant):
            guard let auth = CryptoKitten.HMAC.authenticate(key: key, message: message, variant: variant) else {
                throw Error.AuthenticateError
            }
            return auth
        }
    }
}