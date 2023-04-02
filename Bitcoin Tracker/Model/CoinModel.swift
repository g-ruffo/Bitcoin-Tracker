//
//  CoinModel.swift
//  Bitcoin Tracker
//
//  Created by Grayson Ruffo on 2023-04-01.
//

import Foundation

struct CoinModel: Decodable {
    let assetIdQuote: String
    let rate: Double
    
    func getRate() -> String{
        return String(format: "%.2f", rate)
    }
}
