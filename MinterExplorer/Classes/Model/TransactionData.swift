//
//  TransactionData.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 09/08/2018.
//

import Foundation
import ObjectMapper
import MinterCore


public class TransactionData {
	public var from: String?
	public var to: String?
}

public class SendCoinTransactionData : TransactionData {
	public var coin: String?
	public var amount: Decimal?
}

public class SendCoinTransactionDataMappable : SendCoinTransactionData, Mappable {
	
	required public init?(map: Map) {
		super.init()
		
		mapping(map: map)
	}
	
	public func mapping(map: Map) {
		to <- (map["to"], MinterCore.AddressTransformer())
		from <- (map["from"], MinterCore.AddressTransformer())
		coin <- map["coin"]
		amount <- map["amount"]
		//TODO: to transformer
		if let amountStr = map.JSON["amount"] as? String {
			amount = Decimal(string: amountStr)
		}
	}
}

public class ConvertTransactionData : TransactionData {
	public var fromCoin: String?
	public var toCoin: String?
	public var value: Decimal?
	public var valueToBuy: Decimal?
	public var valueToSell: Decimal?
}

public class ConvertTransactionDataMappable : ConvertTransactionData, Mappable {
	
	required public init?(map: Map) {
		super.init()
		
		mapping(map: map)
	}
	
	public func mapping(map: Map) {
		fromCoin <- map["coin_to_sell"]
		toCoin <- map["coin_to_buy"]
		value <- map["value"]
		valueToBuy <- map["value_to_buy"]
		valueToSell <- map["value_to_sell"]
		//TODO: to transformer
		if let valueStr = map.JSON["value"] as? String {
			value = Decimal(string: valueStr)
		}
		
		if let valueStr = map.JSON["value_to_buy"] as? String {
			valueToBuy = Decimal(string: valueStr)
		}
		
		if let valueStr = map.JSON["value_to_sell"] as? String {
			valueToSell = Decimal(string: valueStr)
		}
		
		from <- (map["from"], AddressTransformer())
		to <- (map["from"], AddressTransformer())
	}
}

public class SellAllCoinsTransactionData : TransactionData {
	public var fromCoin: String?
	public var toCoin: String?
	public var value: Decimal?
}

public class SellAllCoinsTransactionDataMappable : SellAllCoinsTransactionData, Mappable {
	
	required public init?(map: Map) {
		super.init()
		
		mapping(map: map)
	}
	
	public func mapping(map: Map) {
		to <- (map["from"], AddressTransformer())
		from <- (map["from"], AddressTransformer())
		fromCoin <- map["coin_to_sell"]
		toCoin <- map["coin_to_buy"]
		value <- map["value_to_sell"]
		
		if let valueStr = map.JSON["value_to_sell"] as? String {
			value = Decimal(string: valueStr)
		}
	}
}
