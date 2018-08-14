//
//  MinterExplorerAPIURL.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 19/05/2018.
//

import Foundation

public let MinterExplorerBaseURL = "https://testnet.explorer.minter.network"
public let MinterExplorerAPIBaseURL = "https://testnet.explorer.minter.network/api/v1/"
public let MinterExplorerWebSocketURL = "wss://rtm.explorer.minter.network/connection/websocket"


enum MinterExplorerAPIURL {
	
	case balance(address: String)
	case transactions
	case transaction(hash: String)
	case addresses
	case balanceChannel
	
	
	func url() -> URL {
		switch self {
			
		case .addresses:
			return URL(string: MinterExplorerAPIBaseURL + "address")!
			
		case .balance(let address):
			return URL(string: MinterExplorerAPIBaseURL + "balance/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
			
		case .transaction(let hash):
			return URL(string: MinterExplorerAPIBaseURL + "transaction/" + hash.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
			
		case .transactions:
			return URL(string: MinterExplorerAPIBaseURL + "transactions")!
			
		case .balanceChannel:
			return URL(string: MinterExplorerAPIBaseURL + "address/get-balance-channel")!
			
		}
	}
}
