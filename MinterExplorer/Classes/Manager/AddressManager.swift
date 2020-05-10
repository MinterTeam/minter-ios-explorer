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
	/// Method retreived info about address
	///
	/// - SeeAlso: https://testnet.explorer.minter.network/help/index.html
	/// - Parameters:
	///   - address: Address with "Mx" prefix
	///   - withSum: Should include total sums and USD representatives
	///   - completion: Method which will be called after request finished
	public func address(address: String,
											withSum: Bool = false,
											completion: (([String: Any]?, Error?) -> ())?) {

		let url = MinterExplorerAPIURL.address(address: address).url()
		//HACK: Can't change URLEncoding for now
		self.httpClient.getRequest(url,
															 parameters: ["with_sum": withSum ? "true" : "false"] as [String: AnyObject]) { (response, error) in

			var res: [String : Any]?
			var err: Error?

			defer {
				completion?(res, err)
			}

			guard nil == error,
				let data = response.data as? [String : Any] else {
					if nil == error {
						err = BaseManagerError.badResponse
					} else {
						err = error
					}
					return
			}
			res = data
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
