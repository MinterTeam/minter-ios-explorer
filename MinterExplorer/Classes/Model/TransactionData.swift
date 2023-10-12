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
	public var coin: Coin?
	public var amount: Decimal?
}

public class MultisendCoinTransactionData: TransactionData {

	public struct MultisendValues {
		public var coin: Coin
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
    coin = Mapper<CoinMappable>().map(JSONObject: map.JSON["coin"])
		amount <- (map["value"], DecimalTransformer())
	}
}

internal class MultisendCoinTransactionDataMappable: MultisendCoinTransactionData, Mappable {

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {

		if let list = map.JSON["list"] as? [[String: Any]] {

			values = list.map { (val) -> MultisendValues in
        let coin = Mapper<CoinMappable>().map(JSONObject: val["coin"]) ?? Coin.baseCoin()
				let to = (val["to"] as? String) ?? ""
				let value = Decimal(string: (val["value"] as? String) ?? "") ?? 0.0
				return MultisendValues(coin: coin, to: to, value: value)
			}
		}
	}
}

public class ConvertTransactionData: TransactionData {
	public var fromCoin: Coin?
	public var toCoin: Coin?
	public var valueToBuy: Decimal?
	public var valueToSell: Decimal?
}

internal class ConvertTransactionDataMappable: ConvertTransactionData, Mappable {

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
		fromCoin = Mapper<CoinMappable>().map(JSONObject: map.JSON["coin_to_sell"])
		toCoin = Mapper<CoinMappable>().map(JSONObject: map.JSON["coin_to_buy"])
		valueToBuy <- (map["value_to_buy"], DecimalTransformer())
		valueToSell <- (map["value_to_sell"], DecimalTransformer())
		to <- (map["from"], AddressTransformer())
	}
}

public class SellAllCoinsTransactionData: TransactionData {
	public var fromCoin: Coin?
	public var toCoin: Coin?
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
		fromCoin = Mapper<CoinMappable>().map(JSONObject: map.JSON["coin_to_sell"])
		toCoin = Mapper<CoinMappable>().map(JSONObject: map.JSON["coin_to_buy"])
		valueToSell <- (map["value_to_sell"], DecimalTransformer())
		valueToBuy <- (map["value_to_buy"], DecimalTransformer())
		minimumValueToBuy <- (map["minimum_value_to_buy"], DecimalTransformer())
	}
}

public protocol DelegatableUnbondableTransactionData: class {
	var publicKey: String? {get set}
	var coin: Coin? {get set}
	var value: Decimal? {get set}
}

public class DelegateTransactionData: TransactionData, DelegatableUnbondableTransactionData {
	public var publicKey: String?
	public var coin: Coin?
	public var value: Decimal?
}

internal class DelegateTransactionDataMappable: DelegateTransactionData, Mappable {

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
    publicKey <- map["pub_key"]
		coin = Mapper<CoinMappable>().map(JSONObject: map.JSON["coin"])
		value <- (map["value"], DecimalTransformer())
	}
}

public class UnbondTransactionData: TransactionData, DelegatableUnbondableTransactionData {
	public var publicKey: String?
	public var coin: Coin?
	public var value: Decimal?
}

internal class UnbondTransactionDataMappable: DelegateTransactionDataMappable {}

/// RedeemCheckTransaction class
public class RedeemCheckRawTransactionData: TransactionData {
	public var rawCheck: String?
	public var proof: String?
	public var sender: String?
	public var dueBlock: Int?
	public var coin: Coin?
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
    coin = Mapper<CoinMappable>().map(JSONObject: (map.JSON["check"] as? [String: Any])?["coin"])
		value <- (map["check.value"], DecimalTransformer())
	}
}

/// DeclareCandidacyRawTransactionData class
public class DeclareCandidacyTransactionData: TransactionData {
	public var publicKey: String?
	public var coin: Coin?
	public var stake: Decimal?
	public var address: String?
  public var commission: Int?
}

internal class DeclareCandidacyTransactionDataMappable: DeclareCandidacyTransactionData, Mappable {

	// MARK: -

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
    publicKey <- map["pub_key"]
		coin = Mapper<CoinMappable>().map(JSONObject: map.JSON["coin"])
		stake <- (map["stake"], DecimalTransformer())
		address <- (map["address"], AddressTransformer())
    commission <- map["commission"]
	}

}

///  SetCandidateBaseTransactionData class
public class SetCandidateBaseTransactionData: TransactionData {
	public var publicKey: String?
}

internal class SetCandidateBaseTransactionDataMappable: SetCandidateBaseTransactionData, Mappable {

	// MARK: -

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
    publicKey <- map["pub_key"]
	}

}

/// EditCandidateTransactionData class
public class EditCandidateTransactionData: TransactionData {
	public var publicKey: String?
	public var rewardAddress: String?
	public var ownerAddress: String?
  public var controlAddress: String?
}

internal class EditCandidateTransactionDataMappable: EditCandidateTransactionData, Mappable {

	// MARK: -

	required public init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	public func mapping(map: Map) {
    publicKey <- map["pub_key"]
		rewardAddress <- (map["reward_address"], AddressTransformer())
		ownerAddress <- (map["owner_address"], AddressTransformer())
    controlAddress <- (map["control_address"], AddressTransformer())
	}

}

/// EditCandidatePublicKeyTransactionData class
public class EditCandidatePublicKeyTransactionData: TransactionData {
  public var publicKey: String?
  public var newPublicKey: String?
}

internal class EditCandidatePublicKeyTransactionDataMappable: EditCandidatePublicKeyTransactionData, Mappable {

  // MARK: -

  required public init?(map: Map) {
    super.init()

    mapping(map: map)
  }

  public func mapping(map: Map) {
    publicKey <- map["pub_key"]
    newPublicKey <- map["new_pub_key"]
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

public class CreateCoinTransactionData: TransactionData {
  public var initialAmount: Decimal?
  public var initialReserve: Decimal?
  public var symbol: String?
  public var name: String?
  public var maxSupply: Decimal?
  public var constantReserveRatio: Int?
}

internal class CreateCoinTransactionDataMappable: CreateCoinTransactionData, Mappable {

  required public init?(map: Map) {
    super.init()

    mapping(map: map)
  }

  public func mapping(map: Map) {
    initialAmount <- (map["initial_amount"], DecimalTransformer())
    initialReserve <- (map["initial_reserve"], DecimalTransformer())
    symbol <- map["symbol"]
    name <- map["name"]
    maxSupply <- (map["max_supply"], DecimalTransformer())
    constantReserveRatio <- map["constant_reserve_ratio"]
  }

}

public class RecreateCoinTransactionData: CreateCoinTransactionData {}

internal class RecreateCoinTransactionDataMappable: RecreateCoinTransactionData, Mappable {

  required public init?(map: Map) {
    super.init()

    mapping(map: map)
  }

  public func mapping(map: Map) {
    initialAmount <- (map["initial_amount"], DecimalTransformer())
    initialReserve <- (map["initial_reserve"], DecimalTransformer())
    symbol <- map["symbol"]
    name <- map["name"]
    maxSupply <- (map["max_supply"], DecimalTransformer())
    constantReserveRatio <- map["constant_reserve_ratio"]
  }

}

public class SetHaltBlockTransactionData: TransactionData {
  public var publicKey: String?
  public var height: UInt?
}

internal class SetHaltBlockTransactionDataMappable: SetHaltBlockTransactionData, Mappable {

  required public init?(map: Map) {
    super.init()

    mapping(map: map)
  }

  public func mapping(map: Map) {
    publicKey <- map["pub_key"]
    height <- map["height"]
  }

}

public class PriceVoteTransactionData: TransactionData {
  public var price: Decimal?
}

internal class PriceVoteTransactionDataMappable: PriceVoteTransactionData, Mappable {

  required public init?(map: Map) {
    super.init()

    mapping(map: map)
  }

  public func mapping(map: Map) {
    price <- (map["price"], DecimalTransformer())
  }

}

public class ChangeCoinOwnerTransactionData: TransactionData {
  public var coinSymbol: String?
  public var owner: String?
}

internal class ChangeCoinOwnerTransactionDataMappable: ChangeCoinOwnerTransactionData, Mappable {

  required public init?(map: Map) {
    super.init()

    mapping(map: map)
  }

  public func mapping(map: Map) {
    coinSymbol <- map["symbol"]
    owner <- map["new_owner"]
  }

}

public class EditMultisigOwnderTransactionData: TransactionData {
  public var threshold: Int?
  public var weights: [Int]?
  public var addresses: [String]?
}

internal class EditMultisigOwnderTransactionDataMappable: EditMultisigOwnderTransactionData, Mappable {

  required public init?(map: Map) {
    super.init()

    mapping(map: map)
  }

  public func mapping(map: Map) {
    threshold <- map["threshold"]
    weights <- map["weights"]
    addresses <- map["addresses"]
  }

}
