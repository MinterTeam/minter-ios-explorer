//
//  CoinManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 07/09/2018.
//

import Foundation
import MinterCore
import ObjectMapper

public class ExplorerCoinManager : BaseManager {
	
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
			}
		}
	}
}
