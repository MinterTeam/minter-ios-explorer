//
//  BlockManagerTests.swift
//  MinterExplorer_Tests
//
//  Created by Alexey Sidorov on 24/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterExplorer


class BlockManagerTestsSpec: QuickSpec {
	
	let httpClient = APIClient()
	
	var manager: ExplorerBlockManager!
	
	
	override func spec() {
		
		describe("ExplorerBlockManagerTests") {
			
			it("Manager can be initialized") {
				
				let manager = ExplorerBlockManager(httpClient: self.httpClient)
				expect(manager).toNot(beNil())
			}
			
			it("Get blocks") {
				self.manager = ExplorerBlockManager(httpClient: self.httpClient)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					
					self.manager.blocks(page: 0, completion: { (resp, error) in
						expect(resp).toNot(beNil())
						expect(error).to(beNil())
						done()
					})
				}
			}
			
			it("Get block by number") {
				self.manager = ExplorerBlockManager(httpClient: self.httpClient)
				expect(self.manager).toNot(beNil())
				
				waitUntil(timeout: 10.0) { done in
					
					self.manager.block(height: 1420, completion: { (resp, error) in
						expect(resp).toNot(beNil())
						expect(error).to(beNil())
						done()
					})
				}
			}
			
			
			
		}
	}
	
}
