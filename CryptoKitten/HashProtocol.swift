//
//  HashProtocol.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 17/08/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//

import C7

public protocol HashProtocol {
    var message: Array<Byte> { get }
    
    /** Common part for hash calculation. Prepare header data. */
    func prepare(len:Int) -> Array<Byte>
}

extension HashProtocol {
    
    func prepare(len:Int) -> Array<Byte> {
        var tmpMessage = message
        
        // Step 1. Append Padding Bits
        tmpMessage.append(0x80) // append one bit (Byte with one bit) to message
        
        // append "0" bit until message length in bits ≡ 448 (mod 512)
        var msgLength = tmpMessage.count
        var counter = 0
        
        while msgLength % len != (len - 8) {
            counter += 1
            msgLength += 1
        }
        
        tmpMessage += Array<Byte>(repeating: 0, count: counter)
        return tmpMessage
    }
}