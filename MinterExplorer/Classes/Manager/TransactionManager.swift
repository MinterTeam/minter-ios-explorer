//
//  TransactionManager.swift
//  Alamofire
//
//  Created by Alexey Sidorov on 19/05/2018.
//

import Foundation
import MinterCore
import ObjectMapper

public enum ExplorerTransactionManagerError : Error {
	case canNotParseResponse
}

/// Transaction Manager
public class ExplorerTransactionManager : BaseManager {

	/**
	Method recieves transaction list from the Minter Explorer server
	- SeeAlso: https://testnet.explorer.minter.network/help/index.html
	- Parameters:
	- addresses: Addresses for which balance should be retreived
	- page: used for paging
	- completion: Method which will be called after request finished
	- Precondition: each address in `addresses` should contain "Mx" prefix (e.g. Mx228e5a68b847d169da439ec15f727f08233a7ca6)
	- Precondition: The result list can't contain more than 50 items
	*/
	public func transactions(addresses: [String], page: Int = 0, completion: (([MinterExplorer.Transaction]?, Error?) -> ())?) {

		let url = MinterExplorerAPIURL.transactions.url()

		self.httpClient.getRequest(url, parameters: ["addresses" : addresses, "page" : page]) { (response, error) in

			var res: [MinterExplorer.Transaction]?
			var err: Error?

			defer {
				completion?(res, err)
			}

			guard nil == error else {
				err = error
				return
			}

			guard let jsonArray = response.data as? [[String : Any]] else {
				res = []
				return
			}

			res = Mapper<MinterExplorer.TransactionMappable>().mapArray(JSONArray: jsonArray)

		}
	}

	/// Method recieves transaction from the Minter Explorer
	///
	/// - Parameters:
	///   - hash: Transaction hash with "Mt" prefix
	///   - completion: method which will be called after request finished
	public func transaction(hash: String, completion: ((MinterExplorer.Transaction?, Error?) -> ())?) {

		let url = MinterExplorerAPIURL.transaction(hash: hash).url()

		self.httpClient.getRequest(url, parameters: nil) { (response, err) in

			var transaction: MinterExplorer.Transaction?
			var error: Error?

			defer {
				completion?(transaction, error)
			}

			guard nil == err else {
				error = err
				return
			}

			guard let jsonArray = response.data as? [String : Any] else {
				error = BaseManagerError.badResponse
				return
			}

			transaction = Mapper<MinterExplorer.TransactionMappable>().map(JSON: jsonArray)

		}
	}
}
