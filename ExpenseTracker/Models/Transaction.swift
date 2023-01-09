//
//  Transaction.swift
//  ExpenseTracker
//
//  Created by admin on 28/12/22.
//

import Foundation
import SwiftUIFontIcon

struct Transaction: Identifiable, Codable, Hashable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var icon: FontAwesomeCode {
        if let category = Category.allCategories.first(where: {$0.id == categoryId}) {
            return category.icon
        }
        return .question
    }
    
    var parsedDate: Date {
        date.parsedDate()
    }
    
    var signedAmount: Double {
        return type == TransactionType.debit.rawValue ? -amount : amount
    }
    
    var month: String {
        let groupTransaction = parsedDate.formatted(.dateTime.year().month(.wide))
        return groupTransaction
    }
    
}

enum TransactionType: String {
    case credit = "credit"
    case debit = "debit"
}

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryId: Int?
}
