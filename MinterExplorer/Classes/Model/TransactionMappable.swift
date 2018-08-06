//
//  TransactionMappable.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 21/05/2018.
//

import Foundation
import MinterCore
import ObjectMapper


class TransactionMappable : Transaction, Mappable {
	
	let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd HH:mm:ss+zzzz", locale: Locale.current.identifier)
	
	//MARK: - Mappable
	
	required init?(map: Map) {
		super.init()
	}
	
//	func mapping(map: Map) {
//
//		self.hash <- map["hash"]
//		self.type <- map["type"]
////		self.from <- (map["data.from"], AddressTransformer())
////		self.to <- (map["data.to"], AddressTransformer())
////		self.coinSymbol <- (map["data.coin"], CaseTransformer(case: .uppercase))
//		self.date <- (map["timestamp"], DateFormatterTransform(dateFormatter: dateFormatter))
//	}
	
	func mapping(map: Map) {
		self.hash <- map["hash"]
		self.type <- map["type"]
		self.txn <- map["txn"]
		
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
			}
		}
		self.date <- (map["timestamp"], DateFormatterTransform(dateFormatter: dateFormatter))
	}

}
