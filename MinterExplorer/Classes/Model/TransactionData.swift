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
	public var valueToSell: Decimal?
	public var valueToBuy: Decimal?
	public var minimumValueToBuy: Decimal?
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
		valueToSell <- (map["value_to_sell"], DecimalTransformer())
		valueToBuy <- (map["value_to_buy"], DecimalTransformer())
		minimumValueToBuy <- (map["minimum_value_to_buy"], DecimalTransformer())
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

/// RedeemCheckTransaction class
public class RedeemCheckRawTransactionData: TransactionData {
	public var rawCheck: String?
	public var proof: String?
	public var sender: String?
	public var dueBlock: Int?
	public var coin: String?
	public var value: Decimal?
}

internal class RedeemCheckRawTransactionDataMappable: RedeemCheckRawTransactionData, Mappable {

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
		rawCheck <- map["raw_check"]
		proof <- map["proof"]
		sender <- map["check.sender"]
		dueBlock <- map["check.due_block"]
		coin <- map["check.coin"]
		value <- (map["check.value"], DecimalTransformer())
	}
}

/// DeclareCandidacyRawTransactionData class
public class DeclareCandidacyTransactionData: TransactionData {
	public var pubKey: String?
	public var coin: String?
	public var stake: Decimal?
	public var address: String?
}

internal class DeclareCandidacyTransactionDataMappable: DeclareCandidacyTransactionData, Mappable {

	// MARK: -

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
		pubKey <- map["pub_key"]
		coin <- map["coin"]
		stake <- (map["stake"], DecimalTransformer())
		address <- (map["address"], AddressTransformer())
	}

}

///  SetCandidateBaseTransactionData class
public class SetCandidateBaseTransactionData: TransactionData {
	public var pubKey: String?
}

internal class SetCandidateBaseTransactionDataMappable: SetCandidateBaseTransactionData, Mappable {

	// MARK: -

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
		pubKey <- map["pub_key"]
	}

}

/// EditCandidateTransactionData class
public class EditCandidateTransactionData: TransactionData {
	public var pubKey: String?
	public var rewardAddress: String?
	public var ownerAddress: String?
}

internal class EditCandidateTransactionDataMappable: EditCandidateTransactionData, Mappable {

	// MARK: -

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
		pubKey <- map["pub_key"]
		rewardAddress <- (map["rewardAddress"], AddressTransformer())
		ownerAddress <- (map["ownerAddress"], AddressTransformer())
	}

}

public class CreateMultisigAddressTransactionData: TransactionData {
  public var threshold: UInt?
  public var weights: [UInt]?
  public var addresses: [String]?
  public var multisigAddress: String?
}

internal class CreateMultisigAddressTransactionDataMappable: CreateMultisigAddressTransactionData, Mappable {

  // MARK: -

  required public init?(map: Map) {
    super.init()

    mapping(map: map)
  }

  public func mapping(map: Map) {
    threshold <- map["threshold"]
    weights <- map["weights"]
    addresses <- (map["addresses"], AddressTransformer())
    multisigAddress <- map["multisig_address"]
  }
}

