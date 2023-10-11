//
//  CoinManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 07/09/2018.
//

import Foundation
import MinterCore
import ObjectMapper

public struct CoinManagerEstimateResponse: Mappable {

  public var swapType: String?
  public var amountIn: Decimal?
  public var amountOut: Decimal?
  public var coins: [CoinMappable]?

  public init?(map: Map) {
    self.mapping(map: map)
  }

  mutating public func mapping(map: Map) {
    self.swapType <- map["swap_type"]
    self.amountIn <- (map["amount_in"], DecimalTransformer())
    self.amountOut <- (map["amount_out"], DecimalTransformer())
    self.coins <- map["coins"]
  }

}

/// Coin Manager
public class ExplorerCoinManager: BaseManager {

  public func estimate(fromCoin: String, toCoin: String, type: String, amount: Decimal, completion: ((CoinManagerEstimateResponse?, Error?) -> ())?) {
    let url = MinterExplorerAPIURL.estimate(from: fromCoin, to: toCoin).url()
    self.httpClient.getRequest(url, parameters: ["type": type, "amount": amount]) { (response, error) in
      var resp: CoinManagerEstimateResponse?
      var err: Error?

      defer {
        completion?(resp, err)
      }

      guard error == nil else {
        err = error
        return
      }

      if let data = response.data as? [String: Any] {
        resp = Mapper<CoinManagerEstimateResponse>().map(JSON: data)
      }
    }
  }

  public func route(fromCoin: String, toCoin: String, type: String, amount: Decimal, completion: ((Decimal?, [Coin]?, Error?) -> ())?) {
    let url = MinterExplorerAPIURL.route(from: fromCoin, to: toCoin).url()

    self.httpClient.getRequest(url, parameters: ["type": type, "amount": amount]) { (response, error) in

      var amountOut: Decimal?
      var coins: [Coin]?
      var err: Error?

      defer {
        completion?(amountOut, coins, err)
      }

      guard error == nil else {
        err = error
        return
      }

      if let data = response.data as? [String: Any] {
        if let amountOutStr = data["amount_out"] as? String {
          amountOut = Decimal(string: amountOutStr)
        }
        
        coins = Mapper<CoinMappable>().mapArray(JSONObject: data["coins"])
      }
      
    }
  }

	/// Method retreives coins from Explorer
	///
	/// - Parameters:
	///   - term: term to find coins
	///   - completion: Method which will be called after request completed
	public func coins(term: String? = nil, completion: (([Coin]?, Error?) -> ())?) {

		var params = [String : Any]()
		if let term = term {
			params["symbol"] = term
		}

		let url = MinterExplorerAPIURL.coins.url()

		self.httpClient.getRequest(url, parameters: params) { (response, error) in

			var coins: [Coin]?
			var err: Error?

			defer {
				completion?(coins, err)
			}

			guard nil == error else {
				err = error
				return
			}

			if let coinsArray = response.data as? [[String : Any]] {
				coins = Mapper<CoinMappable>().mapArray(JSONArray: coinsArray)
			} else {
				err = BaseManagerError.badResponse
			}
		}
	}
  
  public func verifiedCoins(completion: (([Coin]?, Error?) -> ())?) {

    let url = MinterExplorerAPIURL.verifiedCoins.url()

    self.httpClient.getRequest(url, parameters: [:]) { (response, error) in

      var coins: [Coin]?
      var err: Error?

      defer {
        completion?(coins, err)
      }

      guard nil == error else {
        err = error
        return
      }

      if let coinsArray = response.data as? [[String : Any]] {
        coins = Mapper<CoinMappable>().mapArray(JSONArray: coinsArray)
      } else {
        err = BaseManagerError.badResponse
      }
    }
  }

}
