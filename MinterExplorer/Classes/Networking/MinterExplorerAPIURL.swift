//
//  MinterExplorerAPIURL.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 19/05/2018.
//

import Foundation

public let MinterExplorerBaseURL = MinterExplorerSDK.shared.webURL?.absoluteString
public let MinterExplorerAPIBaseURL = (MinterExplorerSDK.shared.APIURL?.absoluteString ?? "") + "/api/v2/"
public let MinterExplorerWebSocketURL = MinterExplorerSDK.shared.websocketURL

enum MinterExplorerAPIURL {

	case coins
  case verifiedCoins

	case balance(address: String)

  case transactions(address: String)
	case transaction(hash: String)

  case route(from: String, to: String)
  case estimate(from: String, to: String)

	case address(address: String)
	case addressDelegations(address: String)
	case addresses

	case block(height: Int)
	case blockTransaction(height: Int)
	case blocks
  
  case validators

	case status
	case statusPage

	func url() -> URL {
		switch self {

		// Address
		case .address(let address):
			return URL(string: MinterExplorerAPIBaseURL + "addresses/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		case .addressDelegations(let address):
			let address = address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
			return URL(string: MinterExplorerAPIBaseURL + "addresses/" + address + "/delegations")!

		case .addresses:
			return URL(string: MinterExplorerAPIBaseURL + "addresses")!

		// Coins
		case .coins:
			return URL(string: MinterExplorerAPIBaseURL + "coins")!

    case .verifiedCoins:
      return URL(string: MinterExplorerAPIBaseURL + "coins/oracle/verified")!

		case .balance(let address):
			return URL(string: MinterExplorerAPIBaseURL + "balance/" + address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		case .transaction(let hash):
			return URL(string: MinterExplorerAPIBaseURL + "transactions/" + hash.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)!

		case .transactions(let address):
      let address = address.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
      return URL(string: MinterExplorerAPIBaseURL + "addresses/" + address  + "/transactions")!

    case .route(let from, let to):
      return URL(string: MinterExplorerAPIBaseURL + "pools/coins/\(from)/\(to)/route")!

    case .estimate(let from, let to):
      return URL(string: MinterExplorerAPIBaseURL + "pools/coins/\(from)/\(to)/estimate")!

		// Blocks
		case .block(let height):
			return URL(string: MinterExplorerAPIBaseURL + "blocks/" + String(height))!

		case .blockTransaction(let height):
			return URL(string: MinterExplorerAPIBaseURL + "blocks/" + String(height) + "/transactions")!

		case .blocks:
			return URL(string: MinterExplorerAPIBaseURL + "blocks")!

    //Validators
    case .validators:
      return URL(string: MinterExplorerAPIBaseURL + "validators")!

		// Status
		case .status:
			return URL(string: MinterExplorerAPIBaseURL + "status")!

		case .statusPage:
			return URL(string: MinterExplorerAPIBaseURL + "status-page")!
		}
	}
}
