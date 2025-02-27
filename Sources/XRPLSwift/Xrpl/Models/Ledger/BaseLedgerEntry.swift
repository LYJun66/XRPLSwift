//
//  BaseLedgerEntry.swift
//
//
//  Created by Denis Angell on 7/30/22.
//

// https://github.com/XRPLF/xrpl.js/blob/main/packages/xrpl/src/models/ledger/BaseLedgerEntry.ts

import Foundation

open class BaseLedgerEntry: Codable {
    let index: String

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        index = try values.decode(String.self, forKey: .index)
    }
}
