//
//  SignerListSet.swift
//  AnyCodable
//
//  Created by Mitch Lang on 2/10/20.
//

import Foundation

// https://github.com/XRPLF/xrpl.js/blob/main/packages/xrpl/src/models/transactions/signerListSet.ts

//public struct SignerEntry {
//    var Account: String
//    var SignerWeight: Int
//}

public class SignerListSet: BaseTransaction {
    /*
     Represents a `SignerListSet <https://xrpl.org/signerlistset.html>`_
     transaction, which creates, replaces, or removes a list of signers that
     can be used to `multi-sign a transaction
     <https://xrpl.org/multi-signing.html>`_.
     */
    
    public var signerQuorum: Int
    /*
     This field is required.
     :meta hide-value:
     */
    public var signerEntries: [SignerEntry] = []
    
    enum CodingKeys: String, CodingKey {
        case signerQuorum = "SignerQuorum"
        case signerEntries = "SignerEntries"
    }
    
    public init(
        signerQuorum: Int,
        signerEntries: [SignerEntry]
    ) {
        self.signerQuorum = signerQuorum
        self.signerEntries = signerEntries
        super.init(account: "", transactionType: "SignerListSet")
    }
    
    public override init(json: [String: AnyObject]) throws {
        let decoder: JSONDecoder = JSONDecoder()
        let data: Data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let r = try decoder.decode(SignerListSet.self, from: data)
        self.signerQuorum = r.signerQuorum
        self.signerEntries = r.signerEntries
        try super.init(json: json)
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        signerQuorum = try values.decode(Int.self, forKey: .signerQuorum)
        signerEntries = try values.decode([SignerEntry].self, forKey: .signerEntries)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: encoder)
        try values.encode(signerQuorum, forKey: .signerQuorum)
        try values.encode(signerEntries, forKey: .signerEntries)
    }
}


let MAX_SIGNERS: Int = 8

/**
 * Verify the form and type of an SignerListSet at runtime.
 *
 * @param tx - An SignerListSet Transaction.
 * @throws When the SignerListSet is Malformed.
 */
func validateSignerListSet(tx: [String: AnyObject]) throws -> Void {
    try validateBaseTransaction(common: tx)
    
    if (tx["SignerQuorum"] == nil) {
        throw ValidationError.decoding("SignerListSet: missing field SignerQuorum")
    }
    
    if !(tx["SignerQuorum"] is Int) {
        throw ValidationError.decoding("SignerListSet: invalid SignerQuorum")
    }
    
    if (tx["SignerEntries"] == nil) {
        throw ValidationError.decoding("SignerListSet: missing field SignerEntries")
    }
    
    guard let signerEntries = tx["SignerEntries"] as? [[String: AnyObject]] else {
        throw ValidationError.decoding("SignerListSet: invalid SignerEntries")
    }
    
    if signerEntries.count == 0 {
        throw ValidationError.decoding("SignerListSet: need atleast 1 member in SignerEntries")
    }
    
    if signerEntries.count > MAX_SIGNERS {
        throw ValidationError.decoding("SignerListSet: maximum of 8 members allowed in SignerEntries")
    }
}
