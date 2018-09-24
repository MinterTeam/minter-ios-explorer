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
	
	
	private var transactionManager: MinterExplorer.TransactionManager?
	
	private var addressesManager: MinterExplorer.AddressManager?
	
	private var infoManager: MinterExplorer.InfoManager?
	
	private var blockManager: MinterExplorer.BlockManager?
	
	private var coinManager: MinterExplorer.ExplorerCoinManager?
	
	/// HTTP Client
	private let http = APIClient.shared

	override func viewDidLoad() {
		super.viewDidLoad()
		
		coinManager = MinterExplorer.CoinManager(httpClient: http)
		coinManager?.coins(term: "MN") { coin, error in
			print(coin)
			print(error)
		}
		
		
		
		let addresses = ["Mx228e5a68b847d169da439ec15f727f08233a7ca6"]
		
		/// Tranasctions
		transactionManager = MinterExplorer.TransactionManager(httpClient: http)
		transactionManager?.transactions(addresses: addresses, completion: { (transactions, error) in
			print("Transactions:")
			print(transactions ?? [])
			print("Error: \(String(describing: error))")
		})
		
		transactionManager?.transaction(hash: "Mtecc04e7ca110a69b46af6fb0afc8c89ea459e6a1", completion: { (transaction, error) in
			
			print(transaction)
			print(error)
			
		})
		
		/// Addresses
		addressesManager = AddressManager(httpClient: http)
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
		
		
		infoManager = InfoManager(httpClient: http)
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
		
		
		blockManager = BlockManager(httpClient: http)
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
