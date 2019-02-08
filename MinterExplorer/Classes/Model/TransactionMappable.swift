//
//  TransactionMappable.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 21/05/2018.
//

import Foundation
import ObjectMapper
import BigInt



/// Transaction Model
open class Transaction {
	
	/// Transaction type
	public enum TransactionType: String {
		case send = "send"
		case buy = "buyCoin"
		case sell = "sellCoin"
		case sellAllCoins = "sellAllCoin"
		case delegate = "delegate"
		case unbond = "unbond"
	}
	
	public init() {}
	
	public var hash: String?
	public var type: TransactionType?
	public var txn: Int?
	public var data: TransactionData?
	public var date: Date?
	public var from: String?
}


/// Transaction Mapper
class TransactionMappable : Transaction, Mappable {
	
	private static let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", locale: Locale.current.identifier)
	
	//MARK: - Mappable
	
	required init?(map: Map) {
		super.init()
	}
	
	func mapping(map: Map) {
		self.hash <- map["hash"]
		self.type <- map["type"]
		self.txn <- map["txn"]
		self.from <- map["from"]
		
		if nil != type, let data = map.JSON["data"] as? [String : Any] {
			switch type! {
			case .sell, .buy:
				self.data = Mapper<ConvertTransactionDataMappable>().map(JSON: data)
				break
				
			case .send:
				self.data = Mapper<SendCoinTransactionDataMappable>().map(JSON: data)
				break
				
			case .sellAllCoins:
				self.data = Mapper<SellAllCoinsTransactionDataMappable>().map(JSON: data)
				break
				
			case .delegate:
				self.data = Mapper<DelegateTransactionDataMappable>().map(JSON: data)
				break
				
			case .unbond:
				self.data = Mapper<DelegateTransactionDataMappable>().map(JSON: data)
				break
			}
		}
		self.date <- (map["timestamp"], DateFormatterTransform(dateFormatter: TransactionMappable.dateFormatter))
	}

}
