//
//  IAPHelper.swift
//  starfighter
//
//  Created by Greg on 2/19/20.
//  Copyright © 2020 Caveman Games. All rights reserved.
//

import StoreKit
import Foundation

class IAPHelper: NSObject {
    
    typealias ProductsRequestCompletionHandler = (_ products: [SKProduct]?) -> ()
    
    private let productIdentifiers: Set<String>
    private var productsRequest: SKProductsRequest?
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    
    init(prodIds: Set<String>) {
        productIdentifiers = prodIds
        super.init()
    }
}

extension IAPHelper {
    func requestProducts(completionHandler: @escaping ProductsRequestCompletionHandler) {
        productsRequest?.cancel()
        productsRequestCompletionHandler = completionHandler
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self as SKProductsRequestDelegate
        productsRequest?.start()
    }
}

extension IAPHelper: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        productsRequestCompletionHandler?(response.products)
        productsRequestCompletionHandler = .none
        productsRequest = .none
    }
    
    private func request(request: SKRequest, didFailWithError error: NSError) {
        print("Error: \(error.localizedDescription)")
        productsRequestCompletionHandler?(.none)
        productsRequestCompletionHandler = .none
        productsRequest = .none
    }
    
}
