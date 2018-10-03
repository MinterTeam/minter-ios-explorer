//
//  ViewController.swift
//  MinterExplorer
//
//  Created by sidorov.panda on 05/19/2018.
//  Copyright (c) 2018 sidorov.panda. All rights reserved.
//

import UIKit
import MinterCore
import MinterExplorer


class ViewController: UIViewController {
	
	
	private var transactionManager: MinterExplorer.ExplorerTransactionManager?
	
	private var addressesManager: MinterExplorer.ExplorerAddressManager?
	
	private var infoManager: MinterExplorer.ExplorerInfoManager?
	
	private var blockManager: MinterExplorer.ExplorerBlockManager?
	
	private var coinManager: MinterExplorer.ExplorerCoinManager?
	
	/// HTTP Client
	private let http = APIClient.shared

	override func viewDidLoad() {
		super.viewDidLoad()
		
		coinManager = MinterExplorer.ExplorerCoinManager(httpClient: http)
		coinManager?.coins(term: "MNT") { coin, error in
			print(coin)
			print(error)
		}
		
		let addresses = ["Mx228e5a68b847d169da439ec15f727f08233a7ca6"]
		
		/// Tranasctions
		transactionManager = MinterExplorer.ExplorerTransactionManager(httpClient: http)
		transactionManager?.transactions(addresses: addresses, completion: { (transactions, error) in
			print("Transactions:")
			print(transactions ?? [])
			print("Error: \(String(describing: error))")
		})
		
		
		transactionManager?.count(for: "Mx228e5a68b847d169da439ec15f727f08233a7ca6", completion: { (val, err) in
			print(val)
			
		})
		
		transactionManager?.estimateCoinBuy(coinFrom: "MNT", coinTo: "SHSCOIN", value: 1000, completion: { (get, comm, err) in
			print(get)
			print(comm)
			print(err)
		})
		
		transactionManager?.estimateCoinSell(coinFrom: "MNT", coinTo: "SHSCOIN", value: 1000, completion: { (get, comm, err) in
			print(get)
			print(comm)
			print(err)
		})
		
		transactionManager?.estimateCommission(for: "f880820d62018a4d4e540000000000000001aae98a4d4e540000000000000094228e5a68b847d169da439ec15f727f08233a7ca6880de0b6b3a764000080801ba0680eff10955f6a0cdbd2ded0494f74dc922b518d2ecc162325d589b20b2ab1f7a00cb1fb02eecb3f2e4ba1f676c34f6ce6b5c94eada2192f5fec45a19b0e8f0601", completion: { (commission, error) in
			
			print(commission)
			print(error)
			
		})
		
		transactionManager?.sendRawTransaction(rawTransaction: "f880820d62018a4d4e540000000000000001aae98a4d4e540000000000000094228e5a68b847d169da439ec15f727f08233a7ca6880de0b6b3a764000080801ba0680eff10955f6a0cdbd2ded0494f74dc922b518d2ecc162325d589b20b2ab1f7a00cb1fb02eecb3f2e4ba1f676c34f6ce6b5c94eada2192f5fec45a19b0e8f0601", completion: { (res, err) in
			
			print(res)
			print(err)
		})
		
		transactionManager?.transaction(hash: "Mtecc04e7ca110a69b46af6fb0afc8c89ea459e6a1", completion: { (transaction, error) in
			
			print(transaction)
			print(error)
			
		})
		
		/// Addresses
		addressesManager = ExplorerAddressManager(httpClient: http)
		addressesManager?.addresses(addresses: addresses, completion: { (addresses, error) in
			print("Addresses:")
			print(addresses ?? [])
			print("Error: \(String(describing: error))")
		})
		
		///
		addressesManager?.balanceChannel(addresses: addresses, completion: { (chanel, token, timestamp, error) in
			print("Chanel: \(String(describing: chanel))")
			print("Token: \(String(describing: token))")
			print("Timestamp: \(String(describing: timestamp))")
			print("Error: \(String(describing: error))")
		})
		
		
		infoManager = ExplorerInfoManager(httpClient: http)
		infoManager?.status(with: { (status, error) in
			print(status ?? "")
			print(error ?? "")
		})
		
		infoManager?.statusPage(with: { (statusPage, error) in
			print(statusPage ?? "")
			print(error ?? "")
		})
		
		infoManager?.txCountChartData(with: { (data, error) in
			print(data ?? "")
			print(error ?? "")
		})
		
		
		blockManager = ExplorerBlockManager(httpClient: http)
		blockManager?.block(height: 1, completion: { (block, error) in
			print(block ?? "")
			print(error ?? "")
		})
		
		blockManager?.blocks(page: 1, completion: { (blocks, error) in
			print(blocks ?? "")
			print(error ?? "")
		})
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
