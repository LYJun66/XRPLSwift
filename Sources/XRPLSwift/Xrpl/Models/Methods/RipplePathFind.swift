//
//  RipplePathFind.swift
//
//
//  Created by Denis Angell on 7/30/22.
//

// https://github.com/XRPLF/xrpl.js/blob/main/packages/xrpl/src/models/methods/ripplePathFind.ts

import Foundation

public struct SourceCurrencyAmount: Codable {
    public let currency: String
    public let issuer: String?
}

/**
 The `ripple_path_find` method is a simplified version of the path_find method
 that provides a single response with a payment path you can use right away.
 Expects a response in the form of a {@link RipplePathFindResponse}.
 */
public class RipplePathFindRequest: BaseRequest {
    /// Unique address of the account that would send funds in a transaction.
    public let sourceAccount: String
    /// Unique address of the account that would receive funds in a transaction.
    public let destinationAccount: String
    /**
     Currency Amount that the destination account would receive in a
     transaction.
     */
    public let destinationAmount: Amount
    /**
     Currency Amount that would be spent in the transaction. Cannot be used
     with `source_currencies`.
     */
    public let sendMax: Amount?
    /**
     Array of currencies that the source account might want to spend. Each
     entry in the array should be a JSON object with a mandatory currency field
     and optional issuer field, like how currency amounts are specified.
     */
    public let sourceCurrencies: SourceCurrencyAmount?
    /// A 20-byte hex string for the ledger version to use.
    public let ledgerHash: String?
    /**
     The ledger index of the ledger to use, or a shortcut string to choose a
     ledger automatically.
     */
    public let ledgerIndex: LedgerIndex?

    enum CodingKeys: String, CodingKey {
        case sourceAccount = "source_account"
        case destinationAccount = "destination_account"
        case destinationAmount = "destination_amount"
        case sendMax = "send_max"
        case sourceCurrencies = "source_currencies"
        case ledgerIndex = "ledger_index"
        case ledgerHash = "ledger_hash"
    }

    public init(
        // Required
        sourceAccount: String,
        destinationAccount: String,
        destinationAmount: Amount,
        // Base
        id: Int? = nil,
        apiVersion: Int? = nil,
        // Optional
        sendMax: Amount? = nil,
        sourceCurrencies: SourceCurrencyAmount? = nil,
        ledgerHash: String? = nil,
        ledgerIndex: LedgerIndex? = nil
    ) {
        // Required
        self.sourceAccount = sourceAccount
        self.destinationAccount = destinationAccount
        self.destinationAmount = destinationAmount
        // Optional
        self.sendMax = sendMax
        self.sourceCurrencies = sourceCurrencies
        self.ledgerHash = ledgerHash
        self.ledgerIndex = ledgerIndex
        super.init(id: id, command: "submit_multisigned", apiVersion: apiVersion)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

public struct PathOption: Codable {
    /// Array of arrays of objects defining payment paths.
    public let pathsComputed: [Path]
    /**
     Currency amount that the source would have to send along this path for the
     destination to receive the desired amount.
     */
    public let sourceAmount: Amount
}

/**
 Response expected from a {@link RipplePathFindRequest}.
 */
public class RipplePathFindResponse: Codable {
    /**
     Array of objects with possible paths to take, as described below. If
     empty, then there are no paths connecting the source and destination
     accounts.
     */
    public let alternatives: [PathOption]
    /// Unique address of the account that would receive a payment transaction.
    public let destinationAccount: String
    /**
     Array of strings representing the currencies that the destination
     accepts, as 3-letter codes like "USD" or as 40-character hex like
     "015841551A748AD2C1F76FF6ECB0CCCD00000000".
     */
    public let destinationCurrencies: [String]
    public let destinationAmount: Amount
    public let fullReply: Bool?
    //    public let id: Int? | String
    public let id: Int?
    public let ledgerCurrentIndex: Int?
    public let sourceAccount: String
    public let validated: Bool

    enum CodingKeys: String, CodingKey {
        case alternatives = "alternatives"
        case destinationAccount = "destination_account"
        case destinationCurrencies = "destination_currencies"
        case destinationAmount = "destination_amount"
        case fullReply = "full_reply"
        case id = "id"
        case ledgerCurrentIndex = "ledger_current_index"
        case sourceAccount = "source_account"
        case validated = "validated"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        alternatives = try values.decode([PathOption].self, forKey: .alternatives)
        destinationAccount = try values.decode(String.self, forKey: .destinationAccount)
        destinationCurrencies = try values.decode([String].self, forKey: .destinationCurrencies)
        destinationAmount = try values.decode(Amount.self, forKey: .destinationAmount)
        fullReply = try values.decode(Bool.self, forKey: .fullReply)
        id = try values.decode(Int.self, forKey: .id)
        ledgerCurrentIndex = try values.decode(Int.self, forKey: .ledgerCurrentIndex)
        sourceAccount = try values.decode(String.self, forKey: .sourceAccount)
        validated = try values.decode(Bool.self, forKey: .validated)
        //        try super.init(from: decoder)
    }

    func toJson() throws -> [String: AnyObject] {
        let data = try JSONEncoder().encode(self)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return jsonResult as! [String: AnyObject]
    }
}
