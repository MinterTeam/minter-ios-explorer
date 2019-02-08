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
					self.manager.transactions(addresses: ["Mx184ac726059e43643e67290666f7b3195093f870"], completion: { (transactions, error) in
						expect(transactions).toNot(beNil())
						expect(transactions?.count).to(beGreaterThan(0))
						done()
					})
				}
			}
			
			it("Can get transaction by hash") {
				self.manager = ExplorerTransactionManager(httpClient: self.httpClient)
				
				expect(self.manager).toNot(beNil())
				
				let hash = "Mte74b8a1cadfc6464fa0d8f4d0bd51fcb5035ced7a9bc2c055b59a65d3f9566c2"
				
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
			
			it("Can get transactions count") {
				self.manager = ExplorerTransactionManager(httpClient: self.httpClient)
				
				expect(self.manager).toNot(beNil())
				
				let address = "Mx184ac726059e43643e67290666f7b3195093f870"
				
				waitUntil(timeout: 10.0) { done in
					self.manager.count(for: address, completion: { (count, error) in
						
						expect(count).toNot(beNil())
						expect(count).to(beGreaterThan(0))
						expect(error).to(beNil())
						done()
					})
				}
			}
			
			it("Can get retreive estimates") {
				self.manager = ExplorerTransactionManager(httpClient: self.httpClient)
				
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.estimateCoinBuy(coinFrom: "MNT", coinTo: "VALIDATOR", value: Decimal(1000000000000.0), completion: { (res1, res2, error) in
						expect(res1).toNot(beNil())
						expect(res1).to(beGreaterThan(0))
						expect(res2).toNot(beNil())
						expect(res2).to(beGreaterThan(0))
						
						expect(error).to(beNil())
						done()
					})
				}
			}
			
			it("Can get retreive estimates") {
				self.manager = ExplorerTransactionManager(httpClient: self.httpClient)
				
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.estimateCoinSell(coinFrom: "MNT", coinTo: "VALIDATOR", value: Decimal(1000000000000.0), completion: { (res1, res2, error) in
						expect(res1).toNot(beNil())
						expect(res1).to(beGreaterThan(0))
						expect(res2).toNot(beNil())
						expect(res2).to(beGreaterThan(0))
						
						expect(error).to(beNil())
						done()
					})
				}
			}
			
			it("Can get retreive estimates") {
				self.manager = ExplorerTransactionManager(httpClient: self.httpClient)
				
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.sendRawTransaction(rawTransaction: "fakeRawTxHere", completion: { (res, error) in
						
						expect(error).toNot(beNil())
						done()
					})
				}
			}

		}
	}
}
