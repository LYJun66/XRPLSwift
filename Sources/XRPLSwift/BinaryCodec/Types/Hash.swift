//
//  Hash.swift
//
//
//  Created by Denis Angell on 7/4/22.
//

// https://github.com/XRPLF/xrpl-py/blob/master/xrpl/core/binarycodec/types/hash.py

import Foundation

class Hash: SerializedType {
    internal var width: Int

    init(_ bytes: [UInt8]? = nil) {
        self.width = bytes?.count ?? 0
        super.init(bytes: bytes ?? [])
    }

    class func from(value: String) throws -> Hash {
        let bytes: [UInt8] = value.hexToBytes
        // TODO: Discuss workaround (Cannot access self in init aka self.getLength() doesnt work)
        if self != Hash.self && bytes.count != self.getLength() {
            throw BinaryError.unknownError(error: "Invalid hash length \(bytes.count). Expected \(self.getLength())")
        }
        return Hash(bytes)
    }

    /**
     Read a Hash object from a BinaryParser
     - parameters:
        - parser: BinaryParser to read the hash from
        - hint: Length of the bytes to read, optional
     */
    override func fromParser(
        parser: BinaryParser,
        hint: Int? = nil
    ) -> Hash {
        return Hash(try! parser.read(n: hint ?? self.width))
    }

    /**
     Overloaded operator for comparing two hash objects
     - parameters:
        - other: The Hash to compare this to
     */
    func compareTo(other: Hash) -> Int {
        return 0
        //        return self.bytes.compare(
        //            (this.constructor as typeof Hash).from(other).bytes,
        //        )
    }

    /**
     - returns:
     the hex-string representation of this Hash
     */
    override func str() -> String {
        return self.toHex()
    }
    //
    //    override func toJson() -> String {
    //        return self.toJson()
    //    }

    /**
     Returns four bits at the specified depth within a hash
     - parameters:
        - depth: The depth of the four bits
     - returns:
     The number represented by the four bits
     */
    func nibblet(depth: Int) -> Int {
        let byteIx = depth > 0 ? (depth / 2) | 0 : 0
        var bytes: UInt8 = self.bytes[byteIx]
        if depth % 2 == 0 {
            bytes = (bytes & 0xf0) >> 4
        } else {
            bytes = bytes & 0x0f
        }
        return Int(bytes)
    }

    class func getLength() -> Int {
        fatalError(BinaryError.notImplemented.localizedDescription)
    }
}
