//
//  String+Ext.swift
//  ExpenseTracker
//
//  Created by Steven Wijaya on 29.08.2023.
//

import Foundation

extension String {
    func getIndex(of str: String) -> Int? {
        guard let range = self.range(of: str) else { return nil }
        return self.distance(from: self.startIndex, to: range.lowerBound)
    }
}
