//
//  Localizable.swift
//
//
//  Created by nori on 2022/03/10.
//

import Foundation

public protocol Localizable {
    var languageCode: String { get }
    var localizedString: String { get }
}

extension Localizable {
    public var languageCode: String { Locale(identifier: Locale.preferredLanguages.first!).languageCode ?? "en" }
}

