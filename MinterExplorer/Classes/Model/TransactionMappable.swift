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
	public var type: TransactionType?
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
			case .sell, .buy:
				self.data = Mapper<ConvertTransactionDataMappable>().map(JSON: data)
				break

      case .createCoin:
        self.data = Mapper<CreateCoinTransactionDataMappable>().map(JSON: data)
        break

			case .send:
				self.data = Mapper<SendCoinTransactionDataMappable>().map(JSON: data)
				break

			case .multisend:
				self.data = Mapper<MultisendCoinTransactionDataMappable>().map(JSON: data)
				break

			case .sellAll:
				self.data = Mapper<SellAllCoinsTransactionDataMappable>().map(JSON: data)
				break

			case .delegate:
				self.data = Mapper<DelegateTransactionDataMappable>().map(JSON: data)
				break

			case .unbond:
				self.data = Mapper<UnbondTransactionDataMappable>().map(JSON: data)
				break

			case .redeemCheck:
				self.data = Mapper<RedeemCheckRawTransactionDataMappable>().map(JSON: data)
				self.from <- map["check.sender"]
				break

			case .declare:
				self.data = Mapper<DeclareCandidacyTransactionDataMappable>().map(JSON: data)
				break

			case .setCandidateOnline:
				self.data = Mapper<SetCandidateBaseTransactionDataMappable>().map(JSON: data)
				break

			case .setCandidateOffline:
				self.data = Mapper<SetCandidateBaseTransactionDataMappable>().map(JSON: data)
				break

			case .editCandidate:
				self.data = Mapper<EditCandidateTransactionDataMappable>().map(JSON: data)
				break

      case .createMultisig:
        self.data = Mapper<CreateMultisigAddressTransactionDataMappable>().map(JSON: data)
        break
			}
		}
		self.date <- (map["timestamp"], DateFormatterTransform(dateFormatter: TransactionMappable.dateFormatter))
	}

}
