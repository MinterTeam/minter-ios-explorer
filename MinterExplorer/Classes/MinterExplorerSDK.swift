//
//  MinterExplorerSDK.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 11/01/2019.
//

import Foundation

public class MinterExplorerSDK {
	
	
	private init() {}
	
	public static let shared = MinterExplorerSDK()
	
	/// Explorer url
	internal var url: URL? = nil
	
	internal var websocketUrl: URL? = nil
	
	/// MinterExplorer SDK initializer
	public class func initialize(urlString: String, websocketUrlString: String?) {
		shared.url = URL(string: urlString)
		
		if let websocketUrl = websocketUrlString {
			shared.websocketUrl = URL(string: websocketUrl)
		}
	}
	
}
