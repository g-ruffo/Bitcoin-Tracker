//
//  CoinData.swift
//  Bitcoin Tracker
//
//  Created by Grayson Ruffo on 2023-04-01.
//

import Foundation

struct CoinData: Decodable {
    let assetIdQuote: String
    let rate: Double
    
    func getRate() -> String{
        return String(format: "%.2f", rate)
    }

}

