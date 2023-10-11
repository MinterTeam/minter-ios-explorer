//
//  PoolManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 06.07.2021.
//

import Foundation
import MinterCore
import ObjectMapper

public struct PoolManagerRouteResponse {
  public var route: [Coin]
  public var type: String
  public var amountIn: Decimal
  public var amountOut: Decimal
}

/// Pool Manager
public class PoolManager: BaseManager {

  public func route(coinFrom: String,
                    coinTo: String,
                    amount: Decimal,
                    type: String = "input",
                    completion: ((PoolManagerRouteResponse?, Error?) -> ())?) {

    let url = MinterExplorerAPIURL.route(from: coinFrom, to: coinTo).url()

    self.httpClient.getRequest(url, parameters: ["amount": amount, "type": type]) { (response, err) in

      var res: PoolManagerRouteResponse? = nil
      var error: Error?

      defer {
        completion?(res, error)
      }

      guard nil == err else {
        error = err
        return
      }

      let json = (response.data as? [String: Any] ?? [:])
      if let jsonArray = json["coins"] as? [[String: Any]],
         let swapType = json["swap_type"] as? String,
         let amountOut = json["amount_out"] as? String,
         let amountIn = json["amount_in"] as? String {
        res = PoolManagerRouteResponse(route: Mapper<CoinMappable>().mapArray(JSONArray: jsonArray),
                                       type: swapType,
                                       amountIn: Decimal(string: amountIn) ?? 0.0,
                                       amountOut: Decimal(string: amountOut) ?? 0.0)
      }
    }
  }
}
