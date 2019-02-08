//
//  CoinManagerTests.swift
//  MinterExplorer_Tests
//
//  Created by Alexey Sidorov on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterExplorer


class CoinManagerTestsSpec: QuickSpec {
	
	let httpClient = APIClient()
	
	var manager: ExplorerCoinManager!
	
	
	override func spec() {
		
		describe("CoinManagerTests") {
			
			it("Manager can be initialized") {
				let manager = ExplorerCoinManager(httpClient: self.httpClient)
				expect(manager).toNot(beNil())
			}
			
			it("Can get coin") {
				self.manager = ExplorerCoinManager(httpClient: self.httpClient)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.coins(completion: { (coin, error) in
						expect(coin).toNot(beNil())
						expect(error).to(beNil())
						done()
					})
				}
			}
			
			it("Can get coin") {
				self.manager = ExplorerCoinManager(httpClient: self.httpClient)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager.coins(term: "MN", completion: { (resp, error) in
						expect(resp).toNot(beNil())
						expect(error).to(beNil())
						done()
						
					})
				}
			}
			
		}
	}
}
