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
	
	func mapping(map: Map) {
		
		self.hash <- map["hash"]
		self.type <- map["type"]
		self.from <- (map["data.from"], AddressTransformer())
		self.to <- (map["data.to"], AddressTransformer())
		self.coinSymbol <- (map["data.coin"], CaseTransformer(case: .uppercase))
		self.value <- map["data.amount"]
		self.date <- (map["timestamp"], DateFormatterTransform(dateFormatter: dateFormatter))
	}

}
