//
//  Definitions.swift
//
//
//  Created by Denis Angell on 7/2/22.
//

import Foundation

public struct LoadDefinitions {
    public var TYPES: [String: Int]
    // swiftlint:disable:next identifier_name
    public var LEDGER_ENTRY_TYPES: [String: Int]
    public var FIELDS: [String: AnyObject]
    // swiftlint:disable:next identifier_name
    public var TRANSACTION_RESULTS: [String: Int]
    // swiftlint:disable:next identifier_name
    public var TRANSACTION_TYPES: [String: Int]
    // swiftlint:disable:next identifier_name
    public var TRANSACTION_TYPES_REVERSE: [Int: String]
    // swiftlint:disable:next identifier_name
    public var TRANSACTION_RESULTS_REVERSE: [Int: String]
    // swiftlint:disable:next identifier_name
    public var LEDGER_ENTRY_TYPES_REVERSE: [Int: String]
    // swiftlint:disable:next identifier_name
    public var TYPE_ORDINAL_MAP: [String: Int] = [:]
    // swiftlint:disable:next identifier_name
    public var FIELD_INFO_MAP: [String: FieldInfo] = [:]
    // swiftlint:disable:next identifier_name
    public var FIELD_HEADER_NAME_MAP: [FieldHeader: String] = [:]

    init(dict: [String: AnyObject]) {
        self.TYPES = dict["TYPES"] as! [String: Int]
        self.TYPE_ORDINAL_MAP = self.TYPES
        self.LEDGER_ENTRY_TYPES = dict["LEDGER_ENTRY_TYPES"] as! [String: Int]
        self.TRANSACTION_RESULTS = dict["TRANSACTION_RESULTS"] as! [String: Int]
        self.TRANSACTION_TYPES = dict["TRANSACTION_TYPES"] as! [String: Int]

        let fields = dict["FIELDS"] as! [[AnyObject]]
        var fieldsDict: [String: AnyObject] = [:]
        _ = fields.map { array in
            let field = array[0] as! String
            fieldsDict[field] = array[1] as! NSDictionary
        }
        self.FIELDS = fieldsDict

        var reverseTT: [Int: String] = [:]
        TRANSACTION_TYPES.forEach({ (key: String, value: Int) in
            reverseTT[value] = key
        })
        self.TRANSACTION_TYPES_REVERSE = reverseTT

        var reverseTR: [Int: String] = [:]
        TRANSACTION_RESULTS.forEach({ (key: String, value: Int) in
            reverseTR[value] = key
        })
        self.TRANSACTION_RESULTS_REVERSE = reverseTR

        var reverseLE: [Int: String] = [:]
        LEDGER_ENTRY_TYPES.forEach({ (key: String, value: Int) in
            reverseLE[value] = key
        })
        self.LEDGER_ENTRY_TYPES_REVERSE = reverseLE

        for field in self.FIELDS {
            let fieldInfo = FieldInfo(dict: field.value as! NSDictionary)
            let header = FieldHeader(
                typeCode: self.TYPE_ORDINAL_MAP[fieldInfo.type]!,
                fieldCode: fieldInfo.nth
            )
            self.FIELD_INFO_MAP[field.key] = fieldInfo
            self.FIELD_HEADER_NAME_MAP[header] = field.key
        }
    }
}

public struct Definitions {
    // instance variables
    public var definitions: LoadDefinitions!

    init() {
        do {
            let data: Data = serializerDefinitions.data(using: .utf8)!
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [String: AnyObject] {
                self.definitions = LoadDefinitions(dict: jsonResult)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func all() -> [String] {
        return [
            "TYPES",
            "FIELDS",
            "TRANSACTION_RESULTS",
            "TRANSACTION_TYPES"
        ]
    }

    /*
     Returns the serialization data type for the given field name.
     `Serialization Type List <https://xrpl.org/serialization.html#type-list>`_

     Args:
     field_name: The name of the field to get the serialization data type for.

     Returns:
     The serialization data type for the given field name.
     */
    func getFieldTypeName(fieldName: String) -> String {
        return definitions.FIELD_INFO_MAP[fieldName]!.type
    }

    /*
     Returns the type code associated with the given field.
     `Serialization Type Codes <https://xrpl.org/serialization.html#type-codes>`_

     Args:
     field_name: The name of the field get a type code for.

     Returns:
     The type code associated with the given field name.

     Raises:
     XRPLBinaryCodecException: If definitions.json is invalid.
     */
    func getFieldTypeCode(fieldName: String) throws -> Int {
        let fieldTypeName: String = self.getFieldTypeName(fieldName: fieldName)
        let fieldTypeCode: Int = definitions.TYPE_ORDINAL_MAP[fieldTypeName]!
        //        if (type(of: fieldTypeCode) != type(of: Int.self)) {
        //            throw BinaryError.unknownError(error: "Field type codes in definitions.json must be ints.")
        //        }
        return fieldTypeCode
    }

    /*
     Returns the field code associated with the given field.
     `Serialization Field Codes <https://xrpl.org/serialization.html#field-codes>`_

     Args:
     field_name: The name of the field to get a field code for.

     Returns:
     The field code associated with the given field.
     */
    func getFieldCode(fieldName: String) -> Int {
        return definitions.FIELD_INFO_MAP[fieldName]!.nth
    }

    /*
     Returns a FieldHeader object for a field of the given field name.

     Args:
     field_name: The name of the field to get a FieldHeader for.

     Returns:
     A FieldHeader object for a field of the given field name.
     */
    func getFieldHeaderFromName(fieldName: String) -> FieldHeader {
        return FieldHeader(
            typeCode: try! self.getFieldTypeCode(fieldName: fieldName),
            fieldCode: try! self.getFieldCode(fieldName: fieldName)
        )
    }

    /*
     Returns the field name described by the given FieldHeader object.

     Args:
     field_header: The header to get a field name for.

     Returns:
     The name of the field described by the given FieldHeader.
     */
    func getFieldNameFromHeader(fieldHeader: FieldHeader) -> String {
        return definitions.FIELD_HEADER_NAME_MAP[fieldHeader]!
    }

    /*
     Return a FieldInstance object for the given field name.
     Args:
     field_name: The name of the field to get a FieldInstance for.
     Returns:
     A FieldInstance object for the given field name.
     */
    func getFieldInstance(fieldName: String) -> FieldInstance {
        let info: FieldInfo = definitions.FIELD_INFO_MAP[fieldName]!
        let fieldHeader = getFieldHeaderFromName(fieldName: fieldName)
        return FieldInstance(
            fieldInfo: info,
            fieldName: fieldName,
            fieldHeader: fieldHeader
        )
    }

    /*
     Return an integer representing the given transaction type string in an enum.
     Args:
     transaction_type: The name of the transaction type to get the enum value for.
     Returns:
     An integer representing the given transaction type string in an enum.
     */
    func getTransactionTypeCode(transactionType: String) -> Int {
        return definitions.TRANSACTION_TYPES[transactionType]!
    }

    /*
     Return string representing the given transaction type from the enum.
     Args:
     transaction_type: The enum value of the transaction type.
     Returns:
     The string name of the transaction type.
     */
    func getTransactionTypeName(transactionType: Int) -> String {
        return definitions.TRANSACTION_TYPES_REVERSE[transactionType]!
    }

    /*
     Return an integer representing the given transaction result string in an enum.
     Args:
     transaction_result_type: The name of the transaction result type to get the
     enum value for.
     Returns:
     An integer representing the given transaction result type string in an enum.
     */
    func getTransactionResultCode(transactionResultType: String) -> Int {
        return definitions.TRANSACTION_RESULTS[transactionResultType]!
    }

    /*
     Return string representing the given transaction result type from the enum.
     Args:
     transaction_result_type: The enum value of the transaction result type.
     Returns:
     The string name of the transaction result type.
     */
    func getTransactionResultName(transactionResultType: Int) -> String {
        return definitions.TRANSACTION_RESULTS_REVERSE[transactionResultType]!
    }

    /*
     Return an integer representing the given ledger entry type string in an enum.
     Args:
     ledger_entry_type: The name of the ledger entry type to get the enum value for.
     Returns:
     An integer representing the given ledger entry type string in an enum.
     */
    func getLedgerEntryTypeCode(ledgerEntryType: String) -> Int {
        return definitions.LEDGER_ENTRY_TYPES[ledgerEntryType]!
    }

    /*
     Return string representing the given ledger entry type from the enum.
     Args:
     ledger_entry_type: The enum value of the ledger entry type.
     Returns:
     The string name of the ledger entry type.
     */
    func getLedgerEntryTypeName(ledgerEntryType: Int) -> String {
        return definitions.LEDGER_ENTRY_TYPES_REVERSE[ledgerEntryType]!
    }
}
