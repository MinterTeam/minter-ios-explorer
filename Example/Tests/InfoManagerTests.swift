//
//  InfoManagerTests.swift
//  MinterExplorer_Example
//
//  Created by Alexey Sidorov on 06/01/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterExplorer


class ExplorerInfoManagerTestsSpec: QuickSpec {
	
	let httpClient = APIClient()
	
	var manager: ExplorerInfoManager!
	
	
	override func spec() {
		
		describe("ExplorerInfoManager") {
			
			it("Manager can be initialized") {
				let manager = ExplorerInfoManager(httpClient: self.httpClient)
				expect(manager).toNot(beNil())
			}
			
			it("Manager can get status") {
				self.manager = ExplorerInfoManager(httpClient: self.httpClient)
				
				waitUntil(timeout: 10.0) { done in
					self.manager.status(with: { (resp, error) in
						expect(resp).toNot(beNil())
						expect(error).to(beNil())
						done()
					})
				}
			}
			
			it("Manager can get statusPage") {
				self.manager = ExplorerInfoManager(httpClient: self.httpClient)
				
				waitUntil(timeout: 10.0) { done in
					self.manager.statusPage(with: { (resp, error) in
						expect(resp).toNot(beNil())
						expect(error).to(beNil())
						done()
					})
				}
			}
			
			it("Manager can get txCountChartData") {
				self.manager = ExplorerInfoManager(httpClient: self.httpClient)
				
				waitUntil(timeout: 10.0) { done in
					self.manager.txCountChartData(with: { (resp, error) in
						expect(resp).toNot(beNil())
						expect(error).to(beNil())
						done()
					})
				}
			}
			
		}
	}
}
