//
//  STObject.swift
//
//
//  Created by Denis Angell on 7/16/22.
//

// https://github.com/XRPLF/xrpl-py/blob/master/xrpl/core/binarycodec/types/st_object.py

import Foundation

// swiftlint:disable:next identifier_name
internal let OBJECT_END_MARKER_BYTE: [UInt8] = [0xE1]
// swiftlint:disable:next identifier_name
internal let OBJECT_END_MARKER: String = "ObjectEndMarker"
// swiftlint:disable:next identifier_name
internal let ST_OBJECT: String = "STObject"
internal let DESTINATION: String = "Destination"
internal let ACCOUNT: String = "Account"
// swiftlint:disable:next identifier_name
internal let SOURCE_TAG: String = "SourceTag"
// swiftlint:disable:next identifier_name
internal let DEST_TAG: String = "DestinationTag"
// swiftlint:disable:next identifier_name
internal let UNL_MODIFY_TX: String = "0066"

// enum AV {
//    case AccountID
//    case Amount
//
//    func all() {
//        return [
//            AV.AccountID.Type,
//            AV.Amount.Type,
//        ]
//    }
// }

struct AssociatedValue {
    //    case AccountID(AccountID)
    //    case b(Double)

    public var field: FieldInstance!
    public var xaddressDecoded: [String: AnyObject]!
    public var parser: BinaryParser!

    init(
        field: FieldInstance,
        xaddressDecoded: [String: AnyObject]
    ) {
        self.field = field
        self.xaddressDecoded = xaddressDecoded
    }

    init(
        field: FieldInstance,
        parser: BinaryParser
    ) {
        self.field = field
        self.parser = parser
    }

    //    func get(type: AV) -> SerializedType? {
    //        switch AV {
    //        case .AccountID:
    //            return
    //        default:
    //            return
    //        }
    //    }

    func from() throws -> SerializedType? {
        if field.associatedType.self is AccountID.Type {
            return try AccountID.from(value: xaddressDecoded[field.name]! as! String)
        }
        if field.associatedType.self is xAmount.Type {
            if let value = xaddressDecoded[field.name] as? String {
                return try xAmount.from(value: value)
            }
            if let value = xaddressDecoded[field.name] as? [String: String] {
                return try xAmount.from(value: value)
            }
            throw BinaryError.unknownError(error: "Invalid SerializedType Amount")
        }
        if field.associatedType.self is Blob.Type {
            return try Blob.from(value: xaddressDecoded[field.name]! as! String)
        }
        if field.associatedType.self is xCurrency.Type {
            return try xCurrency.from(value: xaddressDecoded[field.name]! as! String)
        }
        if field.associatedType.self is Hash256.Type {
            return try Hash256.from(value: xaddressDecoded[field.name]! as! String)
        }
        if field.associatedType.self is Hash160.Type {
            return try Hash160.from(value: xaddressDecoded[field.name]! as! String)
        }
        if field.associatedType.self is Hash128.Type {
            return try Hash128.from(value: xaddressDecoded[field.name]! as! String)
        }
        if field.associatedType.self is Hash.Type {
            return try Hash.from(value: xaddressDecoded[field.name]! as! String)
        }
        if field.associatedType.self is xPathSet.Type {
            return try xPathSet.from(value: xaddressDecoded[field.name]! as! [[[String: AnyObject]]])
        }
        if field.associatedType.self is STArray.Type {
            return try! STArray.from(value: xaddressDecoded[field.name]! as! [[String: AnyObject]])
        }
        if field.associatedType.self is STObject.Type {
            return try! STObject.from(value: xaddressDecoded[field.name]! as! [String: AnyObject])
        }
        if field.associatedType.self is xUInt64.Type {
            if let value = xaddressDecoded[field.name] as? String {
                return try! xUInt64.from(value: value)
            }
            if let value = xaddressDecoded[field.name] as? Int {
                return try! xUInt64.from(value: value)
            }
            throw BinaryError.unknownError(error: "Invalid SerializedType Amount")
        }
        if field.associatedType.self is xUInt32.Type {
            return xUInt32.from(value: xaddressDecoded[field.name]! as! Int)
        }
        if field.associatedType.self is xUInt16.Type {
            return xUInt16.from(value: xaddressDecoded[field.name]! as! Int)
        }
        if field.associatedType.self is xUInt8.Type {
            return xUInt8.from(value: xaddressDecoded[field.name]! as! Int)
        }
        if field.associatedType.self is Vector256.Type {
            return try Vector256.from(value: xaddressDecoded[field.name]! as! [String])
        }
        return nil
    }

    func fromParser(hint: Int? = nil) -> SerializedType? {
        if field.associatedType.self is AccountID.Type {
            return AccountID().fromParser(parser: self.parser)
        }
        if field.associatedType.self is xAmount.Type {
            return try! xAmount().fromParser(parser: self.parser)
        }
        if field.associatedType.self is Blob.Type {
            return try! Blob().fromParser(parser: self.parser, hint: hint)
        }
        if field.associatedType.self is xCurrency.Type {
            return try! xCurrency().fromParser(parser: self.parser)
        }
        if field.associatedType.self is Hash256.Type {
            return try! Hash256().fromParser(parser: self.parser)
        }
        if field.associatedType.self is Hash160.Type {
            return try! Hash160().fromParser(parser: self.parser)
        }
        if field.associatedType.self is Hash128.Type {
            return try! Hash128().fromParser(parser: self.parser)
        }
        if field.associatedType.self is Hash.Type {
            return try! Hash().fromParser(parser: self.parser)
        }
        if field.associatedType.self is xPathSet.Type {
            return try! xPathSet.fromParser(parser: self.parser)
        }
        if field.associatedType.self is STArray.Type {
            return try! STArray().fromParser(parser: self.self.parser, hint: hint)
        }
        if field.associatedType.self is STObject.Type {
            return try! STObject().fromParser(parser: parser, hint: hint)
        }
        if field.associatedType.self is xUInt64.Type {
            return xUInt64().fromParser(parser: self.parser)
        }
        if field.associatedType.self is xUInt32.Type {
            return xUInt32().fromParser(parser: self.parser)
        }
        if field.associatedType.self is xUInt16.Type {
            return xUInt16().fromParser(parser: self.parser)
        }
        if field.associatedType.self is xUInt8.Type {
            return xUInt8().fromParser(parser: self.parser)
        }
        if field.associatedType.self is Vector256.Type {
            return Vector256().fromParser(parser: self.parser)
        }
        return nil
    }
}

func handleXAddress(field: String, xaddress: String) throws -> [String: AnyObject] {
    let result: FullClassicAddress = try AddressCodec.xAddressToClassicAddress(xAddress: xaddress)
    let classicAddress = result.classicAddress
    let tag = result.tag
    var tagName: String = ""
    if field == DESTINATION {
        tagName = DEST_TAG
    } else if field == ACCOUNT {
        tagName = SOURCE_TAG
    } else if tag != nil {
        throw BinaryError.unknownError(error: "\(field) cannot have an associated tag")
    }

    if tag != nil {
        return [ "\(field)": classicAddress, "\(tagName)": tag! ] as [String: AnyObject]
    }
    return [ "\(field)": classicAddress ] as [String: AnyObject]
}

func strToEnum(field: String, value: Any) -> Any {
    // all of these fields have enum values that are used for serialization
    // converts the string name to the corresponding enum code
    if field == "TransactionType", let value = value as? String {
        return Definitions().getTransactionTypeCode(transactionType: value)
    }
    if field == "TransactionResult", let value = value as? String {
        return Definitions().getTransactionResultCode(transactionResultType: value)
    }
    if field == "LedgerEntryType", let value = value as? String {
        return Definitions().getLedgerEntryTypeCode(ledgerEntryType: value)
    }
    return value
}

func enumToStr(field: String, value: Any) -> Any {
    // reverse of the above function
    if field == "TransactionType", let value = value as? Int {
        return Definitions().getTransactionTypeName(transactionType: value)
    }
    if field == "TransactionResult", let value = value as? Int {
        return Definitions().getTransactionResultName(transactionResultType: value)
    }
    if field == "LedgerEntryType", let value = value as? Int {
        return Definitions().getLedgerEntryTypeName(ledgerEntryType: value)
    }
    return value
}

class STObject: SerializedType {
    init(_ bytes: [UInt8]? = nil) {
        super.init(bytes: bytes ?? [])
    }

    override func fromParser(
        parser: BinaryParser,
        hint: Int? = nil
    ) -> STObject {
        let serializer = BinarySerializer()

        while !parser.end() {
            let field = parser.readField()
            if field.name == OBJECT_END_MARKER {
                break
            }
            let associatedValue: SerializedType = try! parser.readFieldValue(field: field)!
            serializer.writeFieldAndValue(field: field, value: associatedValue)
            if field.type == ST_OBJECT {
                serializer.put(bytes: Data(OBJECT_END_MARKER_BYTE))
            }
        }

        return STObject(serializer.sink.toBytes())
    }

    class func from(value: [String: Any], onlySigning: Bool = false) throws -> STObject {
        let serializer = BinarySerializer()

        var xaddressDecoded: [String: AnyObject] = [:]
        // swiftlint:disable:next identifier_name
        for (k, v) in value {
            if v is String && AddressCodec.isValidXAddress(xAddress: v as! String) {
                let handled = try handleXAddress(field: k, xaddress: v as! String)
                if (
                    handled.contains(where: { $0.key == SOURCE_TAG })
                        && handled[SOURCE_TAG] != nil
                        && value.contains(where: { $0.key == SOURCE_TAG })
                        && value[SOURCE_TAG] != nil
                        && handled[SOURCE_TAG] as? Int != value[SOURCE_TAG] as? Int
                ) {
                    throw BinaryError.unknownError(error: "Cannot have mismatched Account X-Address and SourceTag")
                }
                if (
                    handled.contains(where: { $0.key == DEST_TAG })
                        && handled[DEST_TAG] != nil
                        && value.contains(where: { $0.key == DEST_TAG })
                        && value[DEST_TAG] != nil
                        && handled[DEST_TAG] as? Int != value[DEST_TAG] as? Int
                ) {
                    throw BinaryError.unknownError(error: "Cannot have mismatched Destination X-Address and DestinationTag")
                }
                xaddressDecoded.merge(handled) { _, new in new }
            } else {
                xaddressDecoded[k] = strToEnum(field: k, value: v) as AnyObject
            }
        }

        var sortedKeys: [FieldInstance] = []
        for fieldName in xaddressDecoded {
            let fieldInstance = Definitions().getFieldInstance(fieldName: fieldName.key)
            if
                xaddressDecoded[fieldInstance.name] != nil
                    && fieldInstance.isSerialized {
                sortedKeys.append(fieldInstance)
            }
        }
        sortedKeys = sortedKeys.sorted(by: { $0.ordinal < $1.ordinal })

        if onlySigning {
            sortedKeys = sortedKeys.filter({ $0.isSigning })
        }

        var isUnlModify = false

        for field in sortedKeys {
            var associatedValue: SerializedType?
            do {
                let dynamicValue = AssociatedValue(field: field, xaddressDecoded: xaddressDecoded)
                associatedValue = try dynamicValue.from()
            } catch {
                // mildly hacky way to get more context in the error
                // provides the field name and not just the type it's expecting
                // keeps the original stack trace
                throw BinaryError.unknownError(error: "Error processing \(field.name): \(error.localizedDescription)")
            }
            if
                field.name == "TransactionType"
                    && associatedValue?.str() == UNL_MODIFY_TX {
                // triggered when the TransactionType field has a value of 'UNLModify'
                isUnlModify = true
            }
            let isUnlModifyWorkaround = field.name == "Account" && isUnlModify
            // true when in the UNLModify pseudotransaction (after the transaction type
            // has been processed) and working with the Account field
            // The Account field must not be a part of the UNLModify pseudotransaction
            // encoding, due to a bug in rippled
            serializer.writeFieldAndValue(
                field: field,
                value: associatedValue!,
                isUNLModifyWorkaround: isUnlModifyWorkaround
            )
            if field.type == ST_OBJECT {
                _ = serializer.sink.put(bytesArg: OBJECT_END_MARKER_BYTE)
            }
        }
        return STObject(serializer.sink.toBytes())
    }

    override func toJson() -> [String: AnyObject] {
        let parser = BinaryParser(hex: self.toHex())
        var accumulator: [String: AnyObject] = [:]

        while !parser.end() {
            let field: FieldInstance = parser.readField()
            if field.name == OBJECT_END_MARKER {
                break
            }
            let jsonValue: Any = (try! parser.readFieldValue(field: field)! as! SerializedType).toJson()
            accumulator[field.name] = enumToStr(field: field.name, value: jsonValue) as AnyObject
        }
        return accumulator
    }
}
