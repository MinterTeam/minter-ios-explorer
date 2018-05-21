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
	
	var transactionManager: MinterExplorer.TransactionManager?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let http = APIClient.shared
		
		transactionManager = MinterExplorer.TransactionManager(httpClient: http)
		transactionManager?.transactions(address: "c07ec7cdcae90dea3999558f022aeb25dabbeea2", completion: { (transactions, error) in
			print(transactions)
			print(error)
			
			
		})
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

