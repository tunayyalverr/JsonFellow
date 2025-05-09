//
//  Codable+Extension.swift
//  
//
//  Created by Alver, Tunay on 30.10.2022.
//

import Foundation

public extension Encodable {
    func encodeToData() -> Data? {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .deferredToData
        return try? encoder.encode(self)
    }

    func encodeToString() -> String? {
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .deferredToData
        if let jsonData = try? encoder.encode(self) {
            return String(data: jsonData, encoding: .utf8)
        }
        return nil
    }
    
    func toDictionary() -> [String: Any]? {
        guard let data = encodeToData() else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
}

public extension Decodable {
    static func decode(_ data: Data?) -> Self? {
        guard let data else { return nil }
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .deferredToData
        return try? decoder.decode(self, from: data)
    }
    
    static func decode(_ data: String?) -> Self? {
        guard let data else { return nil }
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .deferredToData
        return try? decoder.decode(self, from: Data(data.utf8))
    }
}
