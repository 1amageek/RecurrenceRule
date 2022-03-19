//
//  RecurrenceRule+Localizable.swift
//  
//
//  Created by nori on 2022/03/10.
//

import Foundation

extension RecurrenceRule.Frequency: Localizable {
    public var localizedString: String {
        guard let path = Bundle.module.path(forResource: languageCode, ofType: "lproj"), let bundle = Bundle(path: path) else {
            fatalError()
        }
        return NSLocalizedString(self.rawValue, tableName: nil, bundle: bundle, value: self.rawValue, comment: self.rawValue)
    }
}
