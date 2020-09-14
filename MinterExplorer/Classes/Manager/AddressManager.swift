//
//  AddressManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 21/06/2018.
//

import Foundation
import MinterCore
import ObjectMapper

/// Address Manager
public class ExplorerAddressManager: BaseManager {

  public enum BalanceResponseType {
    case error(error: Error)
    case response(_ response: BalanceResponse)
  }

  public struct BalanceResponse: Mappable {
    public var address: String
    public var balances: [BalanceResponseItem] = []
    public var totalBalanceSum: Decimal?
    public var totalBalanceSumUSD: Decimal?
    public var stakeBalanceSum: Decimal?
    public var stakeBalanceSumUSD: Decimal?

    init?(address: String) {
      guard address.isValidAddress() else { return nil }
      self.address = address
    }

    public init?(map: Map) {
      guard let address = (map.JSON["address"] as? String) else { return nil }
      self.init(address: address)
      mapping(map: map)
    }

    public mutating func mapping(map: Map) {
      self.balances <- map["balances"]
      self.totalBalanceSum <- (map["total_balance_sum"], DecimalTransformer())
      self.totalBalanceSumUSD <- (map["total_balance_sum_usd"], DecimalTransformer())
      self.stakeBalanceSum <- (map["stake_balance_sum"], DecimalTransformer())
      self.stakeBalanceSumUSD <- (map["stake_balance_sum_usd"], DecimalTransformer())
    }
  }

  public struct BalanceResponseItem: Mappable {
    public var coin: Coin
    public var amount: Decimal = 0.0
    public var bipAmount: Decimal = 0.0

    public init?(map: Map) {
      guard let coin = Mapper<CoinMappable>().map(JSONObject: map.JSON["coin"]) else {
        return nil
      }
      self.coin = coin
      mapping(map: map)
    }

    public mutating func mapping(map: Map) {
      self.amount <- (map["amount"], DecimalTransformer())
      self.bipAmount <- (map["bip_amount"], DecimalTransformer())
    }

  }

	/// Method retreived info about address
	///
	/// - SeeAlso: https://testnet.explorer.minter.network/help/index.html
	/// - Parameters:
	///   - address: Address with "Mx" prefix
	///   - withSum: Should include total sums and USD representatives
	///   - completion: Method which will be called after request finished
	public func address(address: String,
											withSum: Bool = false,
                      completion: ((BalanceResponseType) -> ())?) {

		let url = MinterExplorerAPIURL.address(address: address).url()
		//HACK: Can't change URLEncoding for now
    let params = ["with_sum": withSum ? "true" : "false"] as [String: AnyObject]
		self.httpClient.getRequest(url, parameters: params) { (response, error) in

      var responseType: BalanceResponseType
                                
			defer {
				completion?(responseType)
			}

			guard nil == error else {
        responseType = .error(error: error!)
        return
      }

      guard let data = Mapper<BalanceResponse>().map(JSONObject: response.data) else {
        responseType = .error(error: error!)
        return
      }
      responseType = .response(data)
		}
	}

	/**
	Method retreives addresses data from the Minter Explorer server
	- SeeAlso: https://testnet.explorer.minter.network/help/index.html
	- Parameters:
	- addresses: Addresses for which balance should be retreived
	- withSum: Should include total sums and USD representatives
	- completion: Method which will be called after request finished
	- Precondition: each address in `addresses` should contain "Mx" prefix (e.g. Mx228e5a68b847d169da439ec15f727f08233a7ca6)
	*/
	public func addresses(addresses: [String],
												withSum: Bool = false,
												completion: (([[String : Any]]?, Error?) -> ())?) {
		let url = MinterExplorerAPIURL.addresses.url()

		self.httpClient.getRequest(url,
															 parameters: ["addresses" : addresses,
																						"with_sum": withSum ? "true" : "false"])
		{ (response, error) in
			var addresses: [[String : Any]]?
			var err: Error?

			defer {
				completion?(addresses, err)
			}

			guard nil == error,
				let data = response.data as? [[String : Any]] else {
					if nil == error {
						err = BaseManagerError.badResponse
					} else {
						err = error
					}
					return
			}
			addresses = data
		}
	}

	public func delegations(address: String,
													page: Int = 1,
													limit: Int = 50,
													completion: (([AddressDelegation]?, Decimal?, Error?) -> ())?) {

		let url = MinterExplorerAPIURL.addressDelegations(address: address).url()

		self.httpClient.getRequest(url, parameters: ["page": page, "limit": limit]) { (response, error) in
			var resp: [AddressDelegation]?
			var err: Error?
			var total = Decimal(0.0)

			defer {
				completion?(resp, total, err)
			}

			guard let data = response.data as? [[String: Any]],
				error == nil else {
					return
			}

			if let additional = response.meta?["additional"] as? [String: Any] {
				if let totalDelegated = additional["total_delegated_bip_value"] as? String {
					total = Decimal(string: totalDelegated) ?? 0.0
				}
			}
			resp = Mapper<AddressDelegationMappable>().mapArray(JSONArray: data)
		}
	}
}
