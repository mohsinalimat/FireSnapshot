//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation

public protocol FieldNameReferable {
    static var fieldNames: [PartialKeyPath<Self>: String] { get }
}

public extension FieldNameReferable {
    static func fieldName(from keyPath: PartialKeyPath<Self>) -> String? {
        return fieldNames[keyPath]
    }
}
