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
	public var coin: String?
	public var publicKey: String?
	public var value: Decimal?
	public var bipValue: Decimal?
}

internal class AddressDelegationMappable: AddressDelegation, Mappable {

	// MARK: -

	required init?(map: Map) {
		super.init()

		mapping(map: map)
	}

	func mapping(map: Map) {
		coin <- map["coin"]
		publicKey <- map["pub_key"]
		value <- (map["value"], DecimalTransformer())
		bipValue <- (map["bip_value"], DecimalTransformer())
	}
}
