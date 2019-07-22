//
//  SendCoinTransactionDataTests.swift
//  MinterExplorer_Tests
//
//  Created by Alexey Sidorov on 21/12/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import MinterCore
@testable import MinterExplorer
import ObjectMapper

//Sell All
//"data": {
//	"coin_to_sell": "MNT",
//	"coin_to_buy": "BLACKCOIN",
//	"value": "0.031310500497075698",
//	"value_to_buy": "0.031310500497075698",
//	"value_to_sell": "291.467309815533194386",
//	"from": "Mx228e5a68b847d169da439ec15f727f08233a7ca6"
//}

//Sell
//"data": {
//	"coin_to_sell": "MNT",
//	"coin_to_buy": "BLACKCOIN",
//	"value": "0.191749274486567302",
//	"value_to_buy": "0.191749274486567302",
//	"value_to_sell": "1.000000000000000000",
//	"from": "Mx228e5a68b847d169da439ec15f727f08233a7ca6"
//}

//Buy
//"data": {
//	"coin_to_sell": "MNT",
//	"coin_to_buy": "VALIDATOR",
//	"value": "1.000000000000000000",
//	"value_to_buy": "1.000000000000000000",
//	"value_to_sell": "1.582446176203469033",
//	"from": "Mx228e5a68b847d169da439ec15f727f08233a7ca6"
//}


class SendCoinTransactionDataTestsSpec: QuickSpec {
	
	override func spec() {
		
		describe("TransactionDataTests") {
			
			it("Model can be initialized") {
				let to = "Mxfc7281e9e1429c57d6cf02f193e9082e68dc0522"
				let coin = "MNT"
				
				let data = SendCoinTransactionData()
				data.coin = coin
				data.to = to
				
				expect(data).toNot(beNil())
				expect(data.coin).to(equal(coin))
				expect(data.to).to(equal(to))
			}
			
			
			it("Model can be mapped") {
				let to = "Mx228e5a68b847d169da439ec15f727f08233a7ca6"
				let from = "Mx228e5a68b847d169da439ec15f727f08233a7ca5"
				let coin = "MNTT"
				let amount = "1.000000000000000000"
				let validAmount = Decimal(string: amount)!
				
				let json = "{\"to\":\"\(to)\",\"coin\":\"\(coin)\",\"value\":\"\(amount)\",\"from\":\"\(from)\"}"
				
				let model = Mapper<MinterExplorer.SendCoinTransactionDataMappable>().map(JSONString: json)
				expect(model).toNot(beNil())
				expect(model?.to).to(equal(to))
				expect(model?.amount).to(equal(validAmount))
				expect(model?.coin).to(equal(coin))
			}
			
			it("Model can be initialized") {
				
				let fromCoin = "MNT"
				let toCoin = "BELTCOIN"
				let value = Decimal(1.0)
				let valueToBuy = Decimal(2.0)
				let valueToSell = Decimal(3.0)
				
				let data = ConvertTransactionData()
				data.fromCoin = fromCoin
				data.toCoin = toCoin
				data.valueToBuy = valueToBuy
				data.valueToSell = valueToSell
//				data.value = value
				
				expect(data).toNot(beNil())
//				expect(data.value).to(equal(value))
				expect(data.toCoin).to(equal(toCoin))
				expect(data.fromCoin).to(equal(fromCoin))
				expect(data.valueToSell).to(equal(valueToSell))
				expect(data.valueToBuy).to(equal(valueToBuy))
			}
			
			it("Model can be initialized") {
				
				let fromCoin = "MNT"
				let toCoin = "VALIDATOR"
				let value = "1.000000000000000000"
				let valueToSell = "1.582446176203469033"
				let valueToBuy = "1.000000000000000000"
				
				let from = "Mx228e5a68b847d169da439ec15f727f08233a7ca6"
				let validValue = Decimal(1.0)
				let validValueToBuy = Decimal(1.0)
				let validValueToSell = Decimal(string: "1.582446176203469033")!
				
				let json = "{\"coin_to_sell\":\"\(fromCoin)\",\"coin_to_buy\":\"\(toCoin)\",\"value\":\"\(value)\",\"value_to_buy\":\"\(valueToBuy)\",\"value_to_sell\":\"\(valueToSell)\",\"from\":\"\(from)\"}"
				
				let data = Mapper<MinterExplorer.ConvertTransactionDataMappable>().map(JSONString: json)
				
				expect(data).toNot(beNil())
//				expect(data?.value).to(equal(validValue))
				expect(data?.toCoin).to(equal(toCoin))
				expect(data?.fromCoin).to(equal(fromCoin))
				expect(data?.valueToSell).to(equal(validValueToSell))
				expect(data?.valueToBuy).to(equal(validValueToBuy))
			}
			
			it("Model can be initialized") {
				
				let fromCoin = "MNT"
				let toCoin = "VALIDATOR"
				let value = "1.000000000000000000"
				let valueToSell = "1.582446176203469033"
				let valueToBuy = "1.000000000000000000"
				
				let from = "Mx228e5a68b847d169da439ec15f727f08233a7ca6"
				let validValue = Decimal(1.0)
				
				let json = "{\"coin_to_sell\":\"\(fromCoin)\",\"coin_to_buy\":\"\(toCoin)\",\"value\":\"\(value)\",\"value_to_buy\":\"\(valueToBuy)\",\"value_to_sell\":\"\(valueToSell)\",\"from\":\"\(from)\"}"
				
				let data = Mapper<MinterExplorer.SellAllCoinsTransactionDataMappable>().map(JSONString: json)
				
				expect(data).toNot(beNil())
//				expect(data?.value).to(equal(validValue))
				expect(data?.toCoin).to(equal(toCoin))
				expect(data?.fromCoin).to(equal(fromCoin))
			}
			
			it("Model can be initialized") {
				let pubKey = "eebf92355b8e6717bc200d5637de8d8b2d3dec5e81a4555ef0a77482108a3c9b"
				let coin = "MNT"
				let stake = Decimal(20.0)
				
				let model = DelegateTransactionData()
				model.pubKey = pubKey
				model.coin = coin
//				model.stake = stake
				
				expect(model).toNot(beNil())
				expect(model.pubKey).to(equal(pubKey))
				expect(model.coin).to(equal(coin))
//				expect(model.stake).to(equal(stake))
			}
			
		}
	}
}
