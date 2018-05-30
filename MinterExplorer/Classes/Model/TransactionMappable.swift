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
	
	//MARK: - Mappable
	
	required init?(map: Map) {
		super.init()
	}
	
	func mapping(map: Map) {
		self.hash <- map["hash"]
		self.type <- map["type"]
		self.from <- map["data.from"]
		self.to <- map["data.to"]
		self.coinSymbol <- map["data.coin"]
		self.value <- map["data.amount"]
		self.date <- (map["timestamp"], DateTransform())
	}

}
