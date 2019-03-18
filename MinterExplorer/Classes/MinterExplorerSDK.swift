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
	internal var APIURL: URL? = nil
	
	internal var websocketURL: URL? = nil
	
	internal var webURL: URL? = nil
	
	/// MinterExplorer SDK initializer
	public class func initialize(APIURLString: String, WEBURLString: String?, websocketURLString: String?) {
		shared.APIURL = URL(string: APIURLString)
		
		if let websocketUrl = websocketURLString {
			shared.websocketURL = URL(string: websocketUrl)
		}
		
		if let webURL = WEBURLString {
			shared.webURL = URL(string: webURL)
		}
	}

}
