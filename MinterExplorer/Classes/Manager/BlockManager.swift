//
//  BlockManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 14/08/2018.
//

import Foundation
import MinterCore


public class ExplorerBlockManager : BaseManager {
	
	
	/// Method retreives block from the Minter Explorer
	///
	/// - Parameters:
	///   - height: height of a block
	///   - completion: Method which will be called after request completed
	public func block(height: Int, completion: (([String : Any]?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.block(height: height).url()
		
		self.httpClient.getRequest(url, parameters: nil) { (response, error) in
			
			var res: [String : Any]?
			var err: Error?
			
			defer {
				completion?(res, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			guard let json = response.data as? [String : Any] else {
				return
			}
			
			res = json
		}
	}
	
	
	/// Method retreives blocks from the Minter Explorer
	///
	/// - Parameters:
	///   - page: page number
	///   - completion: Method which will be called after request completed
	public func blocks(page: Int, completion: (([[String : Any]]?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.blocks.url()
		
		self.httpClient.getRequest(url, parameters: ["page" : page]) { (response, error) in
			
			var res: [[String : Any]]?
			var err: Error?
			
			defer {
				completion?(res, err)
			}
			
			guard nil == error else {
				err = error
				return
			}
			
			guard let jsonArray = response.data as? [[String : Any]] else {
				return
			}
			
			res = jsonArray
		}
	}
	
	
}
