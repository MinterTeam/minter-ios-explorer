//
//  ValidatorManager.swift
//  MinterExplorer
//
//  Created by Alexey Sidorov on 16.04.2020.
//

import Foundation
import MinterCore
import ObjectMapper

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

      let jsonArray = (response.data as? [[String: Any]] ?? [])
      res = Mapper<ValidatorInfoResponse>().mapArray(JSONArray: jsonArray)
    }
  }
}
