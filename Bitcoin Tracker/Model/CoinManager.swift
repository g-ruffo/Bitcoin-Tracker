//
//  CoinManager.swift
//  Bitcoin Tracker
//
//  Created by Grayson Ruffo on 2023-04-01.
//

import UIKit

protocol CurrencyPickerViewDelegate: UIPickerViewDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, coinPrice: CoinModel)
    func didFailWithError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    var apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CurrencyPickerViewDelegate?
    
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
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(url)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(self, error: error!)
                    return
                }
                if let safeData = data {
                    if let price = parseJSON(safeData) {
                        delegate?.didUpdatePrice(self, coinPrice: price)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let id = decodedData.assetIdQuote
            let rate = decodedData.rate
            return CoinModel(assetIdQuote: id, rate: rate)
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }

    
}
