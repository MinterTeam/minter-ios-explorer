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
	case send
	case transactionsCount(address: String)
	
	case minGas
	
	case estimateCoinSell
	case estimateCoinBuy
	case transactionCommission
	
	case address(address: String)
	case addresses
	
	case block(height: Int)
	case blocks
	
	case status
	case statusPage
	case txCountChartData
	
	
	func url() -> URL {
		switch self {
			
		//Address

		case .address(let address):
			return URL(string: MinterExplorerAPIBaseURL + "addresses/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!
			
		case .addresses:
			return URL(string: MinterExplorerAPIBaseURL + "addresses")!
			
		//
			
		case .coins:
			return URL(string: MinterExplorerAPIBaseURL + "coins")!

		case .balance(let address):
			return URL(string: MinterExplorerAPIBaseURL + "balance/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		case .transaction(let hash):
			return URL(string: MinterExplorerAPIBaseURL + "transactions/" + hash.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		case .transactions:
			return URL(string: MinterExplorerAPIBaseURL + "transactions")!
			
		case .send:
			return URL(string: MinterExplorerAPIBaseURL + "transaction/push")!
			
		case .transactionsCount(let address):
			let ads = address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
			return URL(string: MinterExplorerAPIBaseURL + "transaction/get-count/" + ads)!
			
		case .block(let height):
			return URL(string: MinterExplorerAPIBaseURL + "blocks/" + String(height))!
			
		case .blocks:
			return URL(string: MinterExplorerAPIBaseURL + "blocks")!
			
		case .status:
			return URL(string: MinterExplorerAPIBaseURL + "status")!
			
		case .statusPage:
			return URL(string: MinterExplorerAPIBaseURL + "status-page")!
			
		case .txCountChartData:
			return URL(string: MinterExplorerAPIBaseURL + "tx-count-chart-data")!
			
		case .estimateCoinBuy:
			return URL(string: MinterExplorerAPIBaseURL + "estimate/coin-buy")!
			
		case .estimateCoinSell:
			return URL(string: MinterExplorerAPIBaseURL + "estimate/coin-sell")!
			
		case .transactionCommission:
			return URL(string: MinterExplorerAPIBaseURL + "estimate/tx-commission")!
			
		case .minGas:
			return URL(string: MinterExplorerAPIBaseURL + "min-gas")!
			
		}
	}
}
