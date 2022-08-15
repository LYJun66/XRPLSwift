//
//  Signor.swift
//
//
//  Created by Denis Angell on 8/6/22.
//

//

import Foundation
import BigInt

public class rSigner: Wallet {
    
    /**
     * Takes several transactions with Signer fields (in object or blob form) and creates a
     * single transaction with all Signers that then gets signed and returned.
     *
     * @param transactions - An array of signed Transactions (in object or blob form) to combine into a single signed Transaction.
     * @returns A single signed Transaction which has all Signers from transactions within it.
     * @throws ValidationError if:
     * - There were no transactions given to sign
     * - The SigningPubKey field is not the empty string in any given transaction
     * - Any transaction is missing a Signers field.
     * @category Signing
     */
    //    public func multisign(transactions: [rTransaction] | [String]) -> String {
    public func multisign(transactions: [rTransaction]) throws -> String {
        if transactions.count == 0 {
            throw XrplError.validation("There were 0 transactions to multisign")
        }
        
        for txOrBlob in transactions {
            let tx: rTransaction = getDecodedTransaction(tx: txOrBlob)
            let jsonTx: [String: AnyObject] = try tx.toJson()
            /*
             * This will throw a more clear error for JS users if any of the supplied transactions has incorrect formatting
             */
            // eslint-disable-next-line @typescript-eslint/consistent-type-assertions -- validate does not accept Transaction type
            try validate(transaction: jsonTx)
            if jsonTx["Signers"] == nil || (jsonTx["Signers"] as! [String: AnyObject]).count == 0 {
                throw XrplError.validation("For multisigning all transactions must include a Signers field containing an array of signatures. You may have forgotten to pass the 'forMultisign' parameter when signing.")
            }
            
            if jsonTx["SigningPubKey"] as! String != "" {
                throw XrplError.validation("SigningPubKey must be an empty string for all transactions when multisigning.")
            }
        }
        
        let decodedTransactions: [rTransaction] = transactions.map { tx in
            return getDecodedTransaction(tx: tx)
        }
        
        try validateTransactionEquivalence(transactions: decodedTransactions)
        
        return try BinaryCodec.encode(json: getTransactionWithAllSigners(transactions: decodedTransactions).toJson())
    }
    
    /**
     * Creates a signature that can be used to redeem a specific amount of XRP from a payment channel.
     *
     * @param wallet - The account that will sign for this payment channel.
     * @param channelId - An id for the payment channel to redeem XRP from.
     * @param amount - The amount in drops to redeem.
     * @returns A signature that can be used to redeem a specific amount of XRP from a payment channel.
     * @category Utilities
     */
    //    public func authorizeChannel(
    //      wallet: Wallet,
    //      channelId: String,
    //      amount: String,
    //    ) -> String {
    //      let signingData = encodeForSigningClaim({
    //        channel: channelId,
    //        amount,
    //      })
    //
    //      return signWithKeypair(signingData, wallet.privateKey)
    //    }
    
    /**
     * Verifies that the given transaction has a valid signature based on public-key encryption.
     *
     * @param tx - A transaction to verify the signature of. (Can be in object or encoded string format).
     * @returns Returns true if tx has a valid signature, and returns false otherwise.
     * @category Utilities
     */
    //    public func verifySignature(tx: rTransaction | String) -> Bool {
    //    public func verifySignature(tx: rTransaction) -> Bool {
    //      let decodedTx: rTransaction = getDecodedTransaction(tx)
    //      return verify(
    //        encodeForSigning(decodedTx),
    //        decodedTx.TxnSignature,
    //        decodedTx.SigningPubKey,
    //      )
    //    }
    
    /**
     * The transactions should all be equal except for the 'Signers' field.
     *
     * @param transactions - An array of Transactions which are expected to be equal other than 'Signers'.
     * @throws ValidationError if the transactions are not equal in any field other than 'Signers'.
     */
    func validateTransactionEquivalence(transactions: [rTransaction]) throws -> Void {
        //        let exampleTransaction = JSON.stringify({
        //            ...transactions[0],
        //        Signers: null,
        //        })
        var exampleTx = try transactions[0].toJson()
        exampleTx["Signers"] = nil
        guard try transactions.allSatisfy({ tx in
            var cloneTx = try tx.toJson()
            cloneTx["Signers"] = nil
            //            return (exampleTx === cloneTx)
            return true
        }) else {
            throw XrplError.validation("txJSON is not the same for all signedTransactions")
        }
    }
    
    func getTransactionWithAllSigners(transactions: [rTransaction]) -> rTransaction {
        // Signers must be sorted in the combined transaction - See compareSigners' documentation for more details
        let sortedSigners: [Signer] = transactions.compactMap { tx in
            let cloneTx = try! tx.toJson()
            return cloneTx["Signers"] as? Signer
//        }.sorted(by: compareSigners)
        }
//        return { ...transactions[0], Signers: sortedSigners }
        return transactions[0]
    }
    
    /**
     * If presented in binary form, the Signers array must be sorted based on
     * the numeric value of the signer addresses, with the lowest value first.
     * (If submitted as JSON, the submit_multisigned method handles this automatically.)
     * https://xrpl.org/multi-signing.html.
     *
     * @param left - A Signer to compare with.
     * @param right - A second Signer to compare with.
     * @returns 1 if left \> right, 0 if left = right, -1 if left \< right, and null if left or right are NaN.
     */
    // TODO: Refactor this
    func compareSigners(left: Signer, right: Signer) -> Int {
        if addressToBigNumber(address: left.signer.account) > addressToBigNumber(address: right.signer.account) {
            return 1
        }
        if addressToBigNumber(address: left.signer.account) == addressToBigNumber(address: right.signer.account) {
            return 0
        }
        if addressToBigNumber(address: left.signer.account) < addressToBigNumber(address: right.signer.account) {
            return -1
        }
        return 0
    }
    
    func addressToBigNumber(address: String) -> BigUInt {
        let hex: String = try! XrplCodec.decodeClassicAddress(classicAddress: address).toHex
        let numberOfBitsInHex: Int = 16
        return BigUInt(hex, radix: numberOfBitsInHex)!
    }
    
    func getDecodedTransaction(blob: String) -> rTransaction {
        let decoded: [String: AnyObject] = BinaryCodec.decode(buffer: blob)
        return try! rTransaction(decoded)!
    }
    
    func getDecodedTransaction(tx: rTransaction) -> rTransaction {
        let encoded = try! BinaryCodec.encode(json: tx.toJson())
        let decoded: [String: AnyObject] = BinaryCodec.decode(buffer: encoded)
        return try! rTransaction(decoded)!
    }
}
