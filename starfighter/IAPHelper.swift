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
    
    private override init() {}
    static let shared = IAPHelper()
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()

    func getProducts() {
        let products: Set = [IAPProduct.consumable1.rawValue,
                             IAPProduct.consumable2.rawValue,
                             IAPProduct.consumable3.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }
        
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
}

extension IAPHelper: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
                case .purchasing:
                    break
                case .deferred:
                    break
                case .purchased:
                    handlePurchased(transaction: transaction)
                    queue.finishTransaction(transaction)
                case .failed:
                    handleFailed(transaction: transaction)
                case .restored:
                    handleRestored(transaction: transaction)
                default:
                    queue.finishTransaction(transaction)
            }
        }
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
            case .deferred: return "deferred"
            case .failed: return "failed"
            case .purchased: return "purchased"
            case .purchasing: return "purchasing"
            case .restored: return "restored"
            @unknown default:
            return "unknown fail"
        }
    }
}
