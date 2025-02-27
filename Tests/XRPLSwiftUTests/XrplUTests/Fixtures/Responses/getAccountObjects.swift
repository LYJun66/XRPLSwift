//
//  File.swift
//
//
//  Created by Denis Angell on 7/28/22.
//

import Foundation

let accountObjectFixture = """
{
  "account": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
  "account_objects": [
    {
      "Balance": {
        "currency": "ASP",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "0"
      },
      "Flags": 65536,
      "HighLimit": {
        "currency": "ASP",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "0"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "ASP",
        "issuer": "r3vi7mWxru9rJCxETCyA1CHvzL96eZWx5z",
        "value": "10"
      },
      "LowNode": "0000000000000000",
      "PreviousTxnID":
        "BF7555B0F018E3C5E2A3FF9437A1A5092F32903BE246202F988181B9CED0D862",
      "PreviousTxnLgrSeq": 1438879,
      "index":
        "2243B0B630EA6F7330B654EFA53E27A7609D9484E535AB11B7F946DF3D247CE9"
    },
    {
      "Balance": {
        "currency": "XAU",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "0"
      },
      "Flags": 3342336,
      "HighLimit": {
        "currency": "XAU",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "0"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "XAU",
        "issuer": "r3vi7mWxru9rJCxETCyA1CHvzL96eZWx5z",
        "value": "0"
      },
      "LowNode": "0000000000000000",
      "PreviousTxnID":
        "79B26D7D34B950AC2C2F91A299A6888FABB376DD76CFF79D56E805BF439F6942",
      "PreviousTxnLgrSeq": 5982530,
      "index":
        "9ED4406351B7A511A012A9B5E7FE4059FA2F7650621379C0013492C315E25B97"
    },
    {
      "Balance": {
        "currency": "USD",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "0"
      },
      "Flags": 1114112,
      "HighLimit": {
        "currency": "USD",
        "issuer": "rMwjYedjc7qqtKYVLiAccJSmCwih4LnE2q",
        "value": "0"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "USD",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "5"
      },
      "LowNode": "0000000000000000",
      "PreviousTxnID":
        "6FE8C824364FB1195BCFEDCB368DFEE3980F7F78D3BF4DC4174BB4C86CF8C5CE",
      "PreviousTxnLgrSeq": 10555014,
      "index":
        "2DECFAC23B77D5AEA6116C15F5C6D4669EBAEE9E7EE050A40FE2B1E47B6A9419"
    },
    {
      "Balance": {
        "currency": "MXN",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "481.992867407479"
      },
      "Flags": 65536,
      "HighLimit": {
        "currency": "MXN",
        "issuer": "rHpXfibHgSb64n8kK9QWDpdbfqSpYbM9a4",
        "value": "0"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "MXN",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "1000"
      },
      "LowNode": "0000000000000000",
      "PreviousTxnID":
        "A467BACE5F183CDE1F075F72435FE86BAD8626ED1048EDEFF7562A4CC76FD1C5",
      "PreviousTxnLgrSeq": 3316170,
      "index":
        "EC8B9B6B364AF6CB6393A423FDD2DDBA96375EC772E6B50A3581E53BFBDFDD9A"
    },
    {
      "Balance": {
        "currency": "EUR",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "0.793598266778297"
      },
      "Flags": 1114112,
      "HighLimit": {
        "currency": "EUR",
        "issuer": "rLEsXccBGNR3UPuPu2hUXPjziKC3qKSBun",
        "value": "0"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "EUR",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "1"
      },
      "LowNode": "0000000000000000",
      "PreviousTxnID":
        "E9345D44433EA368CFE1E00D84809C8E695C87FED18859248E13662D46A0EC46",
      "PreviousTxnLgrSeq": 5447146,
      "index":
        "4513749B30F4AF8DA11F077C448128D6486BF12854B760E4E5808714588AA915"
    },
    {
      "Balance": {
        "currency": "CNY",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "0"
      },
      "Flags": 2228224,
      "HighLimit": {
        "currency": "CNY",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "3"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "CNY",
        "issuer": "rnuF96W4SZoCJmbHYBFoJZpR8eCaxNvekK",
        "value": "0"
      },
      "LowNode": "0000000000000008",
      "PreviousTxnID":
        "2FDDC81F4394695B01A47913BEC4281AC9A283CC8F903C14ADEA970F60E57FCF",
      "PreviousTxnLgrSeq": 5949673,
      "index":
        "578C327DA8944BDE2E10C9BA36AFA2F43E06C8D1E8819FB225D266CBBCFDE5CE"
    },
    {
      "Balance": {
        "currency": "DYM",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "1.336889190631542"
      },
      "Flags": 65536,
      "HighLimit": {
        "currency": "DYM",
        "issuer": "rGwUWgN5BEg3QGNY3RX2HfYowjUTZdid3E",
        "value": "0"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "DYM",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "3"
      },
      "LowNode": "0000000000000000",
      "PreviousTxnID":
        "6DA2BD02DFB83FA4DAFC2651860B60071156171E9C021D9E0372A61A477FFBB1",
      "PreviousTxnLgrSeq": 8818732,
      "index":
        "5A2A5FF12E71AEE57564E624117BBA68DEF78CD564EF6259F92A011693E027C7"
    },
    {
      "Balance": {
        "currency": "CHF",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "-0.3488146605801446"
      },
      "Flags": 131072,
      "HighLimit": {
        "currency": "CHF",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "0"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "CHF",
        "issuer": "rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B",
        "value": "0"
      },
      "LowNode": "000000000000008C",
      "PreviousTxnID":
        "722394372525A13D1EAAB005642F50F05A93CF63F7F472E0F91CDD6D38EB5869",
      "PreviousTxnLgrSeq": 2687590,
      "index":
        "F2DBAD20072527F6AD02CE7F5A450DBC72BE2ABB91741A8A3ADD30D5AD7A99FB"
    },
    {
      "Balance": {
        "currency": "BTC",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "0"
      },
      "Flags": 131072,
      "HighLimit": {
        "currency": "BTC",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "3"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "BTC",
        "issuer": "rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B",
        "value": "0"
      },
      "LowNode": "0000000000000043",
      "PreviousTxnID":
        "03EDF724397D2DEE70E49D512AECD619E9EA536BE6CFD48ED167AE2596055C9A",
      "PreviousTxnLgrSeq": 8317037,
      "index":
        "767C12AF647CDF5FEB9019B37018748A79C50EDAF87E8D4C7F39F78AA7CA9765"
    },
    {
      "Balance": {
        "currency": "USD",
        "issuer": "rrrrrrrrrrrrrrrrrrrrBZbvji",
        "value": "-16.00534471983042"
      },
      "Flags": 131072,
      "HighLimit": {
        "currency": "USD",
        "issuer": "r9cZA1mLK5R5Am25ArfXFmqgNwjZgnfk59",
        "value": "5000"
      },
      "HighNode": "0000000000000000",
      "LedgerEntryType": "RippleState",
      "LowLimit": {
        "currency": "USD",
        "issuer": "rvYAfWj5gh67oV6fW32ZzP3Aw4Eubs59B",
        "value": "0"
      },
      "LowNode": "000000000000004A",
      "PreviousTxnID":
        "CFFF5CFE623C9543308C6529782B6A6532207D819795AAFE85555DB8BF390FE7",
      "PreviousTxnLgrSeq": 14365854,
      "index":
        "826CF5BFD28F3934B518D0BDF3231259CBD3FD0946E3C3CA0C97D2C75D2D1A09"
    }
  ],
  "ledger_hash":
    "053DF17D2289D1C4971C22F235BC1FCA7D4B3AE966F842E5819D0749E0B8ECD3",
  "ledger_index": 14378733,
  "validated": true
}
"""
