//
//  AccountTx.swift
//
//
//  Created by Denis Angell on 7/30/22.
//

// https://github.com/XRPLF/xrpl.js/blob/main/packages/xrpl/src/models/methods/accountTx.ts

import AnyCodable
import Foundation

/**
 The account_tx method retrieves a list of transactions that involved the
 specified account. Expects a response in the form of a {@link
 AccountTxResponse}.
 */
public class AccountTxRequest: BaseRequest {
    /// A unique identifier for the account, most commonly the account's address.
    public let account: String
    /**
     Use to specify the earliest ledger to include transactions from. A value
     of -1 instructs the server to use the earliest validated ledger version
     available.
     */
    public let ledgerIndexMin: Int?
    /**
     Use to specify the most recent ledger to include transactions from. A
     value of -1 instructs the server to use the most recent validated ledger
     version available.
     */
    public let ledgerIndexMax: Int?
    /// Use to look for transactions from a single ledger only.
    public let ledgerHash: String?
    /// Use to look for transactions from a single ledger only.
    public let ledgerIndex: LedgerIndex?
    /**
     If true, return transactions as hex strings instead of JSON. The default is
     false.
     */
    public let binary: Bool?
    /**
     If true, returns values indexed with the oldest ledger first. Otherwise,
     the results are indexed with the newest ledger first.
     */
    public let forward: Bool?
    /**
     Default varies. Limit the number of transactions to retrieve. The server
     is not required to honor this value.
     */
    public let limit: Int?
    /**
     Value from a previous paginated response. Resume retrieving data where
     that response left off. This value is stable even if there is a change in
     the server's range of available ledgers.
     */
    public let marker: AnyCodable?

    enum CodingKeys: String, CodingKey {
        case account = "account"
        case ledgerIndexMin = "ledger_index_min"
        case ledgerIndexMax = "ledger_index_max"
        case ledgerHash = "ledger_hash"
        case ledgerIndex = "ledger_index"
        case binary = "binary"
        case forward = "forward"
        case limit = "limit"
        case marker = "marker"
    }

    public init(
        // Required
        account: String,
        // Base
        id: Int? = nil,
        apiVersion: Int? = nil,
        // Optional
        ledgerIndexMin: Int? = nil,
        ledgerIndexMax: Int? = nil,
        ledgerHash: String? = nil,
        ledgerIndex: LedgerIndex? = nil,
        binary: Bool? = nil,
        forward: Bool? = nil,
        limit: Int? = nil,
        marker: AnyCodable? = nil
    ) {
        // Required
        self.account = account
        // Optional
        self.ledgerIndexMin = ledgerIndexMin
        self.ledgerIndexMax = ledgerIndexMax
        self.ledgerHash = ledgerHash
        self.ledgerIndex = ledgerIndex
        self.binary = binary
        self.forward = forward
        self.limit = limit
        self.marker = marker
        super.init(id: id, command: "account_tx", apiVersion: apiVersion)
    }

    override public init(_ json: [String: AnyObject]) throws {
        let decoder = JSONDecoder()
        let data: Data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let decoded = try decoder.decode(AccountTxRequest.self, from: data)
        // Required
        self.account = decoded.account
        // Optional
        self.ledgerIndexMin = decoded.ledgerIndexMin
        self.ledgerIndexMax = decoded.ledgerIndexMax
        self.ledgerHash = decoded.ledgerHash
        self.ledgerIndex = decoded.ledgerIndex
        self.binary = decoded.binary
        self.forward = decoded.forward
        self.limit = decoded.limit
        self.marker = decoded.marker
        try super.init(json)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        account = try values.decode(String.self, forKey: .account)
        ledgerIndexMin = try values.decodeIfPresent(Int.self, forKey: .ledgerIndexMin)
        ledgerIndexMax = try values.decodeIfPresent(Int.self, forKey: .ledgerIndexMax)
        ledgerHash = try values.decodeIfPresent(String.self, forKey: .ledgerHash)
        ledgerIndex = try values.decodeIfPresent(LedgerIndex.self, forKey: .ledgerIndex)
        binary = try values.decodeIfPresent(Bool.self, forKey: .binary)
        forward = try values.decodeIfPresent(Bool.self, forKey: .forward)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        marker = try values.decodeIfPresent(AnyCodable.self, forKey: .marker)
        try super.init(from: decoder)
    }

    override public func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: encoder)
        try values.encode(account, forKey: .account)
        if let ledgerIndexMin = ledgerIndexMin { try values.encode(ledgerIndexMin, forKey: .ledgerIndexMin) }
        if let ledgerIndexMax = ledgerIndexMax { try values.encode(ledgerIndexMax, forKey: .ledgerIndexMax) }
        if let ledgerHash = ledgerHash { try values.encode(ledgerHash, forKey: .ledgerHash) }
        if let ledgerIndex = ledgerIndex { try values.encode(ledgerIndex, forKey: .ledgerIndex) }
        if let binary = binary { try values.encode(binary, forKey: .binary) }
        if let forward = forward { try values.encode(forward, forKey: .forward) }
        if let limit = limit { try values.encode(limit, forKey: .limit) }
        if let marker = marker { try values.encode(marker, forKey: .marker) }
    }
}

public struct AccountTransaction: Codable {
    /// The ledger index of the ledger version that included this transaction.
    //    public let ledgerIndex: Int
    /**
     If binary is True, then this is a hex string of the transaction metadata.
     Otherwise, the transaction metadata is included in JSON format.
     */
    //    public let meta: String | TransactionMetadata
    public let meta: TransactionMetadata
    /// JSON object defining the transaction.
    //    public let tx: Transaction? & ResponseOnlyTxInfo
    public let tx: Transaction?
    /// Unique hashed String representing the transaction.
    public let txBlob: String?
    /**
     Whether or not the transaction is included in a validated ledger. Any
     transaction not yet in a validated ledger is subject to change.
     */
    public let validated: Bool

    enum CodingKeys: String, CodingKey {
        //        case ledgerIndex = "ledger_index"
        case meta = "meta"
        case tx = "tx"
        case txBlob = "tx_blob"
        case validated = "validated"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //        ledgerIndex = try values.decode(Int.self, forKey: .ledgerIndex)
        meta = try values.decode(TransactionMetadata.self, forKey: .meta)
        tx = try values.decodeIfPresent(Transaction.self, forKey: .tx)
        txBlob = try values.decodeIfPresent(String.self, forKey: .txBlob)
        validated = try values.decode(Bool.self, forKey: .validated)
    }

    func toJson() throws -> [String: AnyObject] {
        let data = try JSONEncoder().encode(self)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return jsonResult as! [String: AnyObject]
    }
}

/**
 Expected response from an {@link AccountTxRequest}.
 */
public class AccountTxResponse: Codable {
    /// Unique Address identifying the related account.
    public let account: String
    /**
     Array of transactions matching the request's criteria, as explained
     below.
     */
    public let transactions: [AccountTransaction]
    /**
     The ledger index of the earliest ledger actually searched for
     transactions.
     */
    public let ledgerIndexMin: Int
    /**
     The ledger index of the most recent ledger actually searched for
     transactions.
     */
    public let ledgerIndexMax: Int
    /**
     If included and set to true, the information in this response comes from
     a validated ledger version. Otherwise, the information is subject to
     change.
     */
    public let validated: Bool?

    /*The limit value used in the request. */
    public let limit: Int
    /**
     Server-defined value indicating the response is paginated. Pass this
     to the next call to resume where this call left off.
     */
    public let marker: AnyCodable?

    enum CodingKeys: String, CodingKey {
        case account = "account"
        case transactions = "transactions"
        case ledgerIndexMin = "ledger_index_min"
        case ledgerIndexMax = "ledger_index_max"
        case validated = "validated"
        case limit = "limit"
        case marker = "marker"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        account = try values.decode(String.self, forKey: .account)
        transactions = try values.decode([AccountTransaction].self, forKey: .transactions)
        ledgerIndexMin = try values.decode(Int.self, forKey: .ledgerIndexMin)
        ledgerIndexMax = try values.decode(Int.self, forKey: .ledgerIndexMax)
        validated = try values.decodeIfPresent(Bool.self, forKey: .validated)
        limit = try values.decode(Int.self, forKey: .limit)
        marker = try values.decodeIfPresent(AnyCodable.self, forKey: .marker)
        //        try super.init(from: decoder)
    }

    func toJson() throws -> [String: AnyObject] {
        let data = try JSONEncoder().encode(self)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return jsonResult as! [String: AnyObject]
    }
}
