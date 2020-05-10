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
	public var validatorName: String?
	public var validatorDesc: String?
	public var validatorIconURL: URL?
	public var validatorSiteURL: URL?
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
		validatorName <- map["validator.name"]
		validatorDesc <- map["validator.description"]
		validatorIconURL <- (map["validator.icon_url"], URLTransform())
		validatorSiteURL <- (map["validator.site_url"], URLTransform())
    publicKey <- map["validator.public_key"]
		coin <- map["coin"]
		value <- (map["value"], DecimalTransformer())
		bipValue <- (map["bip_value"], DecimalTransformer())
	}
}
