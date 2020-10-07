//
//  AddressDelegation.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 06/06/2019.
//

import Foundation
import MinterCore
import ObjectMapper

public class AddressDelegation {
  public var validator: Validator?
	public var coin: Coin?
	public var value: Decimal?
	public var bipValue: Decimal?
  public var isWaitlisted: Bool?
}

internal class AddressDelegationMappable: AddressDelegation, Mappable {

	// MARK: -

	required init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	func mapping(map: Map) {
    validator = Mapper<ValidatorMappable>().map(JSONObject: map.JSON["validator"])
    coin = Mapper<CoinMappable>().map(JSONObject: map.JSON["coin"])
		value <- (map["value"], DecimalTransformer())
		bipValue <- (map["bip_value"], DecimalTransformer())
    isWaitlisted <- map["is_waitlisted"]
	}
}
