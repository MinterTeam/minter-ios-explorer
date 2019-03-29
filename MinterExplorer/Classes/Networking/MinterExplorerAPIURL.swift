//
//  MinterExplorerAPIURL.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 19/05/2018.
//

import Foundation

public let MinterExplorerBaseURL = MinterExplorerSDK.shared.webURL?.absoluteString
public let MinterExplorerAPIBaseURL = (MinterExplorerSDK.shared.APIURL?.absoluteString ?? "") + "/api/v1/"
public let MinterExplorerWebSocketURL = MinterExplorerSDK.shared.websocketURL


enum MinterExplorerAPIURL {
	
	case coins
	
	case balance(address: String)
	
	case transactions
	case transaction(hash: String)
	
	case address(address: String)
	case addresses
	
	case block(height: Int)
	case blockTransaction(height: Int)
	case blocks
	
	case status
	case statusPage
	
	
	func url() -> URL {
		switch self {
			
		// Address

		case .address(let address):
			return URL(string: MinterExplorerAPIBaseURL + "addresses/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
			
		case .addresses:
			return URL(string: MinterExplorerAPIBaseURL + "addresses")!
			
		// Coins
			
		case .coins:
			return URL(string: MinterExplorerAPIBaseURL + "coins")!

		case .balance(let address):
			return URL(string: MinterExplorerAPIBaseURL + "balance/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		case .transaction(let hash):
			return URL(string: MinterExplorerAPIBaseURL + "transactions/" + hash.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		case .transactions:
			return URL(string: MinterExplorerAPIBaseURL + "transactions")!
			
		// Blocks
			
		case .block(let height):
			return URL(string: MinterExplorerAPIBaseURL + "blocks/" + String(height))!
			
		case .blockTransaction(let height):
			return URL(string: MinterExplorerAPIBaseURL + "blocks/" + String(height) + "/transactions")!
			
		case .blocks:
			return URL(string: MinterExplorerAPIBaseURL + "blocks")!
			
		// Status
			
		case .status:
			return URL(string: MinterExplorerAPIBaseURL + "status")!
			
		case .statusPage:
			return URL(string: MinterExplorerAPIBaseURL + "status-page")!
			
		//
			
		}
	}
}
