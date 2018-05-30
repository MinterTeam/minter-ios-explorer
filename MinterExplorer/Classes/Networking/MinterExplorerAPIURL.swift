//
//  MinterExplorerAPIURL.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 19/05/2018.
//

import Foundation

public let MinterExplorerBaseURL = "https://testnet.explorer.minter.network"
public let MinterExplorerAPIBaseURL = "https://testnet.explorer.minter.network/api/v1/"


enum MinterExplorerAPIURL {
	
	case balance(address: String)
	case transactions
	
	
	func url() -> URL {
		switch self {
		case .balance(let address):
			return URL(string: MinterExplorerAPIBaseURL + "balance" + address)!
			
		case .transactions:
			let url = URL(string: MinterExplorerAPIBaseURL + "transactions")!
			return url
		}
	}
}
