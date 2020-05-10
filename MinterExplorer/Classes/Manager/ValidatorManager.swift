//
//  ValidatorManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 16.04.2020.
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

  public init?(map: Map) {
    mapping(map: map)
  }

  mutating public func mapping(map: Map) {
    publicKey <- (map["public_key"], PublicKeyTransformer())
    status <- map["status"]
    stake <- (map["stake"], DecimalTransformer())
    name <- map["name"]
    description <- map["description"]
    iconURL <- (map["icon_url"], URLTransform())
    siteURL <- (map["site_url"], URLTransform())
    part <- map["part"]
    delegatorsCount <- map["delegator_count"]
  }

  public var publicKey: PublicKey?
  public var status: Int?
  public var stake: Decimal?
  public var name: String?
  public var description: String?
  public var iconURL: URL?
  public var siteURL: URL?
  public var part: Float?
  public var delegatorsCount: Int?
}

/// Validator Manager
public class ValidatorManager: BaseManager {
  /// Method retreives list of active validators
  ///
  /// - Parameter completion: method which will be called after request finished.
  public func validators(completion: (([ValidatorInfoResponse]?, Error?) -> ())?) {

    let url = MinterExplorerAPIURL.validators.url()

    self.httpClient.getRequest(url, parameters: [:]) { (response, err) in

      var res: [ValidatorInfoResponse]?
      var error: Error?

      defer {
        completion?(res, error)
      }

      guard nil == err else {
        error = err
        return
      }

      let jsonArray = (response.data as? [[String : Any]] ?? [])
      res = Mapper<ValidatorInfoResponse>().mapArray(JSONArray: jsonArray)
    }
  }
}
