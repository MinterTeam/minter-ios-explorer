//
//  TransactionManagerTests.swift
//  MinterExplorer_Tests
//
//  Created by Alexey Sidorov on 06/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterExplorer


class TransactionManagerTestsSpec: QuickSpec {
	
	let httpClient = APIClient()
	
	var manager: ExplorerTransactionManager!
	
	
	override func spec() {
		
		describe("ExplorerInfoManager") {
			
			it("Manager can be initialized") {
				let manager = ExplorerTransactionManager(httpClient: self.httpClient)
				expect(manager).toNot(beNil())
			}
			
			it("Can get transactions for address") {
				self.manager = ExplorerTransactionManager(httpClient: self.httpClient)
				
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.transactions(addresses: ["Mx89f5395a03847826d6b48bb02dbde64376945a20"], completion: { (transactions, error) in
						expect(transactions).toNot(beNil())
						expect(transactions?.count).to(beGreaterThan(0))
						done()
					})
				}
			}
			
			it("Can get transaction by hash") {
				self.manager = ExplorerTransactionManager(httpClient: self.httpClient)
				
				expect(self.manager).toNot(beNil())
				
				let hash = "Mt83bb967a2ffd5f22bf47d282d183fc550ead99a3be0f8b6f9a6a246cce425435"
				
				waitUntil(timeout: 10.0) { done in
					self.manager.transaction(hash: hash, completion: { (transaction, error) in
						expect(transaction).toNot(beNil())
						expect(transaction?.hash).to(equal(hash))
						done()
					})
				}
			}
			
			it("Can't get transaction with wrong hash") {
				self.manager = ExplorerTransactionManager(httpClient: self.httpClient)
				
				expect(self.manager).toNot(beNil())
				
				let hash = "Mt1181f0185dfbda5f6ed497581dce1bf4cbac2a427374bf45018343c7af6471a9"
				
				waitUntil(timeout: 10.0) { done in
					self.manager.transaction(hash: hash, completion: { (transaction, error) in
						expect(transaction).to(beNil())
						expect(error).toNot(beNil())
						done()
					})
				}
			}
		}
	}
}
