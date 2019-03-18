//
//  AddressManagerTests.swift
//  MinterExplorer_Tests
//
//  Created by Alexey Sidorov on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterExplorer


class AddressManagerTestsSpec: QuickSpec {
	
	let httpClient = APIClient()
	
	var manager: ExplorerAddressManager!
	
	
	override func spec() {
		
		describe("AddressManagerTests") {
			
			it("Manager can be initialized") {
				
				let manager = ExplorerAddressManager(httpClient: self.httpClient)
				
				expect(manager).toNot(beNil())
				
			}
			
			it("Manager should get address info") {
				
				self.manager = ExplorerAddressManager(httpClient: self.httpClient)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager?.address(address: "Mxfc7281e9e1429c57d6cf02f193e9082e68dc052d", completion: { (res, error) in
						expect(error).to(beNil())
						expect(res).toNot(beNil())
						done()
					})
				}
			}
			
			it("Should show error on wrong address") {
				
				self.manager = ExplorerAddressManager(httpClient: self.httpClient)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager?.address(address: "111", completion: { (res, error) in
						expect(error).toNot(beNil())
						expect(res).to(beNil())
						done()
					})
				}
			}
			
			it("Should show get info on multiple addresses") {
				
				self.manager = ExplorerAddressManager(httpClient: self.httpClient)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager?.addresses(addresses: ["Mx184ac726059e43643e67290666f7b3195093f870", "Mxa82fdcc182090751d4b66e956810c7e1e2e92ecc"], completion: { (res, error) in
						expect(error).to(beNil())
						expect(res).toNot(beNil())
						done()
					})
				}
			}
			
			it("Shouldn't show get info on multiple addresses with at least one invalid") {
				
				self.manager = ExplorerAddressManager(httpClient: self.httpClient)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					self.manager?.addresses(addresses: ["11", "Mxa82fdcc182090751d4b66e956810c7e1e2e92ecc"], completion: { (res, error) in
						expect(error).toNot(beNil())
						expect(res).to(beNil())
						done()
					})
				}
			}
			
		}
	}
}
