//
//  CaseTransformer.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 04/07/2018.
//

import Foundation
import ObjectMapper


class CaseTransformer : TransformType {
	
	enum `case` {
		case uppercase
		case lowercase
	}
	
	private let selectedCase: `case`
	
	init(case cs: CaseTransformer.`case`) {
		self.selectedCase = cs
	}
	
	typealias Object = String
	
	typealias JSON = String
	
	func transformFromJSON(_ value: Any?) -> Object? {
		if let val = value as? String {
			return selectedCase == .uppercase ? val.uppercased() : val.lowercased()
		}
		return nil
	}
	
	func transformToJSON(_ value: Object?) -> JSON? {
		return value
	}
	
}
