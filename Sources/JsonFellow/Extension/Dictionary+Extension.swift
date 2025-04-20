//
//  Dictionary+Extension.swift
//  JsonFellow
//
//  Created by tunay alver on 20.04.2025.
//

import Foundation

public extension Dictionary where Key == String, Value == Any {
    func toModel<T: Decodable>(_ type: T.Type) -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self) else { return nil }
        return T.decode(data)
    }
}
