//
//  PublicKey.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 22.09.2020.
//

import Foundation
import MinterCore
import ObjectMapper

public struct PublicKey {

  public private(set) var stringValue: String

  public init?(_ string: String) {
    guard string.isValidPublicKey() else {
      return nil
    }

    self.stringValue = "Mp" + string.stripMinterHexPrefix().lowercased()
  }

}

/// DecimalTransformer class
public class PublicKeyTransformer: TransformType {

  // MARK: -

  public init() {}

  public typealias Object = PublicKey

  public typealias JSON = String

  public func transformFromJSON(_ value: Any?) -> Object? {
    if let val = value as? String {
      return PublicKey(val)
    }
    return nil
  }

  public func transformToJSON(_ value: Object?) -> JSON? {
    return value?.stringValue
  }

}

//class PublicKeyTransformer:
public struct ValidatorInfoResponse: Mappable {

  public enum Status: Int {
    case notReady = 1
    case ready = 2
  }

  public init?(map: Map) {
    mapping(map: map)
  }

  mutating public func mapping(map: Map) {
    publicKey <- (map["public_key"], PublicKeyTransformer())
    status <- (map["status"], EnumTransform<Status>())
    stake <- (map["stake"], DecimalTransformer())
    name <- map["name"]
    description <- map["description"]
    iconURL <- (map["icon_url"], URLTransform())
    siteURL <- (map["site_url"], URLTransform())
    part <- map["part"]
    delegatorsCount <- map["delegator_count"]
    minStake <- (map["min_stake"], DecimalTransformer())
    commission <- map["commission"]
  }

  public var publicKey: PublicKey?
  public var status: Status = .notReady
  public var stake: Decimal?
  public var name: String?
  public var description: String?
  public var iconURL: URL?
  public var siteURL: URL?
  public var part: Float?
  public var delegatorsCount: Int?
  public var minStake: Decimal?
  public var commission: Int?
}
