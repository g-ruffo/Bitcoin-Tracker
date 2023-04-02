//
//  CoinData.swift
//  Bitcoin Tracker
//
//  Created by Grayson Ruffo on 2023-04-01.
//

import Foundation

struct CoinData: Decodable {
    let time: String
    let assetIdBase: String
    let assetIdQuote: String
    let rate: Double

}

