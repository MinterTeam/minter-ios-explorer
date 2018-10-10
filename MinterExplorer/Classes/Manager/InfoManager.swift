//
//  InfoManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 15/08/2018.
//

import Foundation
import MinterCore


public class ExplorerInfoManager : BaseManager {
	
	
	/// Method retreives status info from the Minter Explorer
	///
	/// - Parameter completion: Method which will be called after request finishes
	public func status(with completion: (([String : Any]?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.status.url()
		
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
			
			guard let jsonArray = response.data as? [String : Any] else {
				return
			}
			
			res = jsonArray
		}

	}
	
	/// Method retreives statusPage info from the Minter Explorer
	///
	/// - Parameter completion: Method which will be called after request finishes
	public func statusPage(with completion: (([String : Any]?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.statusPage.url()
		
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
			
			guard let jsonArray = response.data as? [String : Any] else {
				return
			}
			
			res = jsonArray
		}
	}
	
	/// Method retreives transaction Count Chart data from the Minter Explorer
	///
	/// - Parameter completion: Method which will be called after request finishes
	public func txCountChartData(with  completion: (([String : Any]?, Error?) -> ())?) {
		
		let url = MinterExplorerAPIURL.txCountChartData.url()
		
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
			
			guard let jsonArray = response.data as? [String : Any] else {
				return
			}
			
			res = jsonArray
		}
	}
}
