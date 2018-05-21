//
//  TransactionManager.swift
//  Alamofire
//
//  Created by Alexey Sidorov on 19/05/2018.
//

import Foundation
import MinterCore
import ObjectMapper

enum TransactionManagerError : Error {
	
}


public class TransactionManager : BaseManager {
	
	public func transactions(address: String, completion: (([MinterCore.Transaction]?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.transactions(address: address).url()
		
		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
			
			var res: [Transaction]?
			var err: Error?
			
			defer {
				completion?(res, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			guard let jsonArray = response.result as? [[String : Any]] else {
				res = []
				return
			}
			
			res = Mapper<TransactionMappable>().mapArray(JSONArray: jsonArray)
			
		}
	}
	
}

