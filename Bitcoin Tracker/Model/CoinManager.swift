//
//  CoinManager.swift
//  Bitcoin Tracker
//
//  Created by Grayson Ruffo on 2023-04-01.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    var apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    init() {
        apiKey = getPlistValueWithKey(fileName: "APIKey", keyName: "coinAPIKey")
    }
    
    mutating func getPlistValueWithKey(fileName: String, keyName: String) -> String {
        var plist: [String: String]?
        if let apiKeyPlistPath = Bundle.main.url(forResource: fileName, withExtension: "plist") {
            do {
                let apiKeyPlistData = try Data(contentsOf: apiKeyPlistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: apiKeyPlistData, options: [], format: nil) as? [String: String] {
                    plist = dict
                    
                    if let value = plist?[keyName] {
                        return value
                    }
                }
            } catch {
                print(error)
            }
        }
        return "Key Name Not Found"
    }
    
    
    func getCoinPrice(for currency: String) {
        
    }

    
}
