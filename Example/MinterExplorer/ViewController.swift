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
	
	/// HTTP Client
	private let http = APIClient.shared

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let addresses = ["Mxc07ec7cdcae90dea3999558f022aeb25dabbeea2"]
		
		/// Tranasctions
		transactionManager = MinterExplorer.TransactionManager(httpClient: http)
		transactionManager?.transactions(addresses: addresses, completion: { (transactions, error) in
			print("Transactions:")
			print(transactions ?? [])
			print("Error: \(String(describing: error))")
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
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
