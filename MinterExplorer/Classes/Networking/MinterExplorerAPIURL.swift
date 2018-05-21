//
//  MinterExplorerAPIURL.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 19/05/2018.
//

import Foundation


let MinterExplorerAPIBaseURL = "https://explorer.beta.minter.network/api/v1/"


enum MinterExplorerAPIURL {
	
	case balance(address: String)
	case transactions(address: String)
	
	
	func url() -> URL {
		switch self {
		case .balance(let address):
			return URL(string: MinterExplorerAPIBaseURL + "balance" + address)!
			
		case .transactions(let address):
			let url = URL(string: MinterExplorerAPIBaseURL + "transactions")!
			var components = URLComponents(string: url.absoluteString)
			components?.queryItems = [URLQueryItem(name: "account", value: address)]
			return components!.url!
			
		}
	}
}
