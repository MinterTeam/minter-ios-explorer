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
	public var to: String?
}

public class SendCoinTransactionData: TransactionData {
	public var coin: String?
	public var amount: Decimal?
}

public class MultisendCoinTransactionData: TransactionData {

	public struct MultisendValues {
		public var coin: String
		public var to: String
		public var value: Decimal
	}

	public var values: [MultisendValues]?
}

internal class SendCoinTransactionDataMappable: SendCoinTransactionData, Mappable {

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
		to <- (map["to"], MinterCore.AddressTransformer())
		coin <- map["coin"]
		amount <- (map["value"], DecimalTransformer())
	}
}

internal class MultisendCoinTransactionDataMappable: MultisendCoinTransactionData, Mappable {

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {

		if let list = map.JSON["list"] as? [[String : String]] {

			values = list.map { (val) -> MultisendValues in
				let coin = val["coin"] ?? ""
				let to = val["to"] ?? ""
				let value = Decimal(string: val["value"] ?? "") ?? 0.0
				return MultisendValues(coin: coin, to: to, value: value)
			}
		}
	}
}

public class ConvertTransactionData: TransactionData {
	public var fromCoin: String?
	public var toCoin: String?
	public var valueToBuy: Decimal?
	public var valueToSell: Decimal?
}

internal class ConvertTransactionDataMappable: ConvertTransactionData, Mappable {

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
		fromCoin <- map["coin_to_sell"]
		toCoin <- map["coin_to_buy"]
		valueToBuy <- (map["value_to_buy"], DecimalTransformer())
		valueToSell <- (map["value_to_sell"], DecimalTransformer())
		to <- (map["from"], AddressTransformer())
	}
}

public class SellAllCoinsTransactionData: TransactionData {
	public var fromCoin: String?
	public var toCoin: String?
	public var value: Decimal?
}

internal class SellAllCoinsTransactionDataMappable: SellAllCoinsTransactionData, Mappable {

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
		to <- (map["from"], AddressTransformer())
		fromCoin <- map["coin_to_sell"]
		toCoin <- map["coin_to_buy"]
		value <- (map["value_to_buy"], DecimalTransformer())
	}
}

public protocol DelegatableUnbondableTransactionData: class {
	var pubKey: String? {get set}
	var coin: String? {get set}
	var value: Decimal? {get set}
}

public class DelegateTransactionData: TransactionData, DelegatableUnbondableTransactionData {
	public var pubKey: String?
	public var coin: String?
	public var value: Decimal?
}

internal class DelegateTransactionDataMappable: DelegateTransactionData, Mappable {

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
		pubKey <- map["pub_key"]
		coin <- map["coin"]
		value <- (map["value"], DecimalTransformer())
	}
}

public class UnbondTransactionData: TransactionData, DelegatableUnbondableTransactionData {
	public var pubKey: String?
	public var coin: String?
	public var value: Decimal?
}

internal class UnbondTransactionDataMappable: DelegateTransactionDataMappable {}
