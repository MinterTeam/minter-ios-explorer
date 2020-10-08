//
//  TransactionMappable.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 21/05/2018.
//

import Foundation
import MinterCore
import ObjectMapper
import BigInt

/// Transaction Model
open class Transaction {

	public init() {}

	public var hash: String?
	public var type: RawTransactionType?
	public var txn: Int?
	public var data: TransactionData?
	public var date: Date?
	public var from: String?
	public var payload: String?
  public var block: Int?
  public var fee: Decimal?
  public var feeCoin: Coin?
}

/// Transaction Mapper
class TransactionMappable: Transaction, Mappable {

	private static let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
																									 locale: Locale.current.identifier)

	// MARK: - Mappable

	required init?(map: Map) {
		super.init()
	}

	func mapping(map: Map) {
		self.hash <- map["hash"]
		self.type <- (map["type"], TransactionTypeTransformer())
		self.txn <- map["txn"]
		self.from <- map["from"]
    self.payload <- map["payload"]
    self.fee <- (map["fee"], DecimalTransformer())
    self.block <- map["height"]
    self.feeCoin = Mapper<CoinMappable>().map(JSONObject: map.JSON["gas_coin"])

		if nil != type, let data = map.JSON["data"] as? [String: Any] {
			switch type! {
			case .sellCoin, .buyCoin:
				self.data = Mapper<ConvertTransactionDataMappable>().map(JSON: data)

      case .createCoin:
        self.data = Mapper<CreateCoinTransactionDataMappable>().map(JSON: data)

			case .sendCoin:
				self.data = Mapper<SendCoinTransactionDataMappable>().map(JSON: data)

			case .multisend:
				self.data = Mapper<MultisendCoinTransactionDataMappable>().map(JSON: data)

			case .sellAllCoins:
				self.data = Mapper<SellAllCoinsTransactionDataMappable>().map(JSON: data)

			case .delegate:
				self.data = Mapper<DelegateTransactionDataMappable>().map(JSON: data)

			case .unbond:
				self.data = Mapper<UnbondTransactionDataMappable>().map(JSON: data)

			case .redeemCheck:
				self.data = Mapper<RedeemCheckRawTransactionDataMappable>().map(JSON: data)
				self.from <- map["check.sender"]

			case .declareCandidacy:
				self.data = Mapper<DeclareCandidacyTransactionDataMappable>().map(JSON: data)

			case .setCandidateOnline:
				self.data = Mapper<SetCandidateBaseTransactionDataMappable>().map(JSON: data)

			case .setCandidateOffline:
				self.data = Mapper<SetCandidateBaseTransactionDataMappable>().map(JSON: data)

			case .editCandidate:
				self.data = Mapper<EditCandidateTransactionDataMappable>().map(JSON: data)

      case .editCandidatePublicKey:
        self.data = Mapper<EditCandidatePublicKeyTransactionDataMappable>().map(JSON: data)

      case .createMultisigAddress:
        self.data = Mapper<CreateMultisigAddressTransactionDataMappable>().map(JSON: data)

      case .setHaltBlock:
        self.data = Mapper<SetHaltBlockTransactionDataMappable>().map(JSON: data)

      case .recreateCoin:
        self.data = Mapper<RecreateCoinTransactionDataMappable>().map(JSON: data)

      case .changeCoinOwner:
        self.data = Mapper<ChangeCoinOwnerTransactionDataMappable>().map(JSON: data)

      case .editMultisigOwner:
        self.data = Mapper<EditMultisigOwnderTransactionDataMappable>().map(JSON: data)

      case .priceVote:
        self.data = Mapper<PriceVoteTransactionDataMappable>().map(JSON: data)
      }
		}

		self.date <- (map["timestamp"], DateFormatterTransform(dateFormatter: TransactionMappable.dateFormatter))
	}

}
