//
//  AddressManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 21/06/2018.
//

import Foundation
import MinterCore


/// Address Manager
public class ExplorerAddressManager : BaseManager {
	
	/// Method retreived info about address
	///
	/// - SeeAlso: https://testnet.explorer.minter.network/help/index.html
	/// - Parameters:
	///   - address: Address with "Mx" prefix
	///   - completion: Method which will be called after request finished
	public func address(address: String, completion: (([String : Any]?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.address(address: address).url()
		
		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
			
			var res: [String : Any]?
			var err: Error?
			
			defer {
				completion?(res, err)
			}
			
			guard nil == error, let data = response.data as? [String : Any] else {
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
	- completion: Method which will be called after request finished
	- Precondition: each address in `addresses` should contain "Mx" prefix (e.g. Mx228e5a68b847d169da439ec15f727f08233a7ca6)
	*/
	public func addresses(addresses: [String], completion: (([[String : Any]]?, Error?) -> ())?) {
	
		let url = MinterExplorerAPIURL.addresses.url()
		
		self.httpClient.getRequest(url, parameters: ["addresses" : addresses]) { (response, error) in
			
			var addresses: [[String : Any]]?
			var err: Error?
			
			defer {
				completion?(addresses, err)
			}
			
			guard nil == error, let data = response.data as? [[String : Any]] else {
				return
			}
			
			addresses = data
			
		}
	}
}
