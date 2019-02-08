//
//  TransactionDataTests.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 21/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterExplorer


class TransactionDataTestsSpec: QuickSpec {
	
	override func spec() {
		
		describe("TransactionDataTests") {
			
			it("Model can be initialized") {
				let to = "Mxfc7281e9e1429c57d6cf02f193e9082e68dc0522"
				let from = "Mxfc7281e9e1429c57d6cf02f193e9082e68dc0521"
				
				let data = TransactionData()
				data.to = to
				
				expect(data).toNot(beNil())
				expect(data.to).to(equal(to))
			}
			
			it("Model can be initialized") {
				let to = "Mxfc7281e9e1429c57d6cf02f193e9082e68dc0522"
				let from = "Mxfc7281e9e1429c57d6cf02f193e9082e68dc0521"
				
				let data = TransactionData()
				data.to = to
				
				expect(data).toNot(beNil())
				expect(data.to).to(equal(to))
			}
			
		}
		
	}
	
}
