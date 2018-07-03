//
//  AddressManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 21/06/2018.
//

import Foundation
import MinterCore


public class AddressManager : BaseManager {

	public func addresses(addresses: [String], completion: (( [[String : Any]]?, Error?) -> ())?) {
	
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
