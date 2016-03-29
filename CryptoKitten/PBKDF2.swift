//
//  PBKDF2.swift
//  CryptoKitten
//
//  Created by Joannis Orlandos on 29/03/16.
//
//

import C7

public final class PBKDF2 {
    /// Used for applying an HMAC variant on a password and salt
    private func digest(password: String, data: [Byte], variant: HMAC.Variant = .sha1) throws -> [Byte] {
        var passwordBytes = [Byte]()
        passwordBytes.append(contentsOf: password.utf8)
        
        return try Authenticator.HMAC(key: passwordBytes, variant: variant).authenticate(data)
    }
    
    /// Applies the `hi` (PBKDF2 with HMAC as PseudoRandom Function)
    public static func calculate(password: String, salt: [Byte], iterations: Int, variant: HMAC.Variant = .sha1) throws -> [Byte] {
        var salt = salt
        salt.append(contentsOf:)(contentsOf: [0, 0, 0, 1])
        
        var ui = try digest(password, data: salt, variant: variant)
        var u1 = ui
        
        for _ in 0..<iterations - 1 {
            u1 = try digest(password, data: u1, variant: variant)
            ui = xor(ui, u1)
        }
        
        return ui
    }
}