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
				return
			}
			
			transaction = Mapper<MinterExplorer.TransactionMappable>().map(JSON: jsonArray)
			
		}
	}
	
	/// Method sends raw transaction to the Minter network
	///
	/// - Parameters:
	///   - rawTransaction: encoded transaction
	///   - completion: method which will be called after request finished
	public func sendRawTransaction(rawTransaction: String, completion: ((String?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.send.url()
		
		self.httpClient.postRequest(url, parameters: ["transaction" : rawTransaction]) { (response, error) in
			
			var tx: String?
			var err: Error?
			
			defer {
				completion?(tx, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let resp = response.data as? [String : Any], let hash = resp["hash"] as? String {
				tx = hash
			}
			else {
				err = ExplorerTransactionManagerError.canNotParseResponse
			}
		}
	}
	
	/// Method retreives transaction count
	///
	/// - Parameters:
	///   - address: "Mx" prefixed address (e.g. Mx184ac726059e43643e67290666f7b3195093f870)
	///   - completion: method which will be called after request finished
	public func count(for address: String, completion: ((Decimal?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.transactionsCount(address: address).url()
		
		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
			
			var count: Decimal?
			var err: Error?
			
			defer {
				completion?(count, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let data = response.data as? [String : Any], let cnt = data["count"] as? Int {
				count = Decimal(cnt)
			}
			else {
				err = ExplorerTransactionManagerError.canNotParseResponse
			}
		}
	}
	
	/// Method retreives minimum gas price
	///
	/// - Parameters:
	///   - completion: method which will be called after request finished
	public func minGas(completion: ((Int?, Error?) -> ())?) {
		let url = MinterExplorerAPIURL.minGas.url()
		
		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
			
			var gas: Int?
			var err: Error?
			
			defer {
				completion?(gas, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let data = response.data as? [String : Any], let cnt = data["gas"] as? Int {
				gas = cnt
			}
			else {
				err = ExplorerTransactionManagerError.canNotParseResponse
			}
		}
		
	}
	
	/// Method retreives estimate coin buy
	///
	/// - Parameters:
	///   - coinFrom: coin to sell (e.g. MNT)
	///   - coinTo: coin to buy (e.g. BELTCOIN)
	///		- value: value to calculate estimates for
	///   - completion: method which will be called after request finished
	public func estimateCoinBuy(coinFrom: String, coinTo: String, value: Decimal, completion: ((Decimal?, Decimal?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.estimateCoinBuy.url()
		
		self.httpClient.getRequest(url, parameters: ["coinToBuy" : coinTo, "coinToSell" : coinFrom, "valueToBuy" : value]) { (response, error) in
			
			var willPay: Decimal?
			var com: Decimal?
			var err: Error?
			
			defer {
				completion?(willPay, com, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let data = response.data as? [String : String], let pay = data["will_pay"], let commission = data["commission"] {
				willPay = Decimal(string: pay)
				com = Decimal(string: commission)
			}
			else {
				err = ExplorerTransactionManagerError.canNotParseResponse
			}
		}
	}
	
	/// Method retreives estimate coin sell
	///
	/// - Parameters:
	///   - coinFrom: coin to sell (e.g. MNT)
	///   - coinTo: coin to buy (e.g. BELTCOIN)
	///		- value: value to calculate estimates for
	///   - completion: method which will be called after request finished
	public func estimateCoinSell(coinFrom: String, coinTo: String, value: Decimal, completion: ((Decimal?, Decimal?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.estimateCoinSell.url()
		
		self.httpClient.getRequest(url, parameters: ["coinToBuy" : coinTo, "coinToSell" : coinFrom, "valueToSell" : value]) { (response, error) in
			
			var willGet: Decimal?
			var com: Decimal?
			var err: Error?
			
			defer {
				completion?(willGet, com, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let data = response.data as? [String : String], let get = data["will_get"], let commission = data["commission"] {
				willGet = Decimal(string: get)
				com = Decimal(string: commission)
			}
			else {
				err = ExplorerTransactionManagerError.canNotParseResponse
			}
		}
	}
	
	/// Method retreives estimate comission for raw transaction
	///
	/// - Parameters:
	///   - rawTx: encoded raw transaction
	///   - completion: method which will be called after request finished
	public func estimateCommission(for rawTx: String, completion: ((Decimal?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.transactionCommission.url()
		
		self.httpClient.getRequest(url, parameters: ["transaction" : rawTx]) { (response, error) in
			
			var com: Decimal?
			var err: Error?
			
			defer {
				completion?(com, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			if let data = response.data as? [String : String], let commission = data["commission"] {
				com = Decimal(string: commission)
			}
			else {
				err = ExplorerTransactionManagerError.canNotParseResponse
			}
		}
	}

}
