//
//  JsonFellow.swift
//
//  Created by tunay alver on 30.10.2022.
//

import Foundation

public enum PathType {
    case locale
    case document
}

public final class JsonFellow  {
    // MARK: - Private

    // MARK: - Path
    private static func jsonPath(_ path: String, _ withType: PathType) -> String? {
        switch withType {
        case .locale:
            return Bundle.main.path(forResource: path, ofType: "json")
        case .document:
            return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? "") + "/" + path + ".json"
        }
    }

    private static func jsonPathLocale(_ path: String) -> String? {
        return Bundle.main.path(forResource: path, ofType: "json")
    }

    private static func filePath(_ name: String) -> String {
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let fileAtPath = filePath?.appendingFormat("/%@", name + ".json")

        return fileAtPath!
    }

    // MARK: - Public

    // MARK: - Data
    /// Produce the data for the given `path`.
    ///
    ///```
    /// JsonFellow.dataFrom("mockData") // returns mockData.json as Data
    /// ```
    ///
    /// - Parameters:
    ///     - path: json path.
    ///     - pathType: json path type. Could be locally dropped to folders or saved to documents with save function. Default is locale.
    ///
    /// - Returns: Data for the given `path`.
    public static func dataFrom(_ path: String, _ withType: PathType) -> Data? {
        guard let path = jsonPath(path, withType)
        else { return nil }

        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }

    // MARK: - Object Make

    /// Produce the expected object for the given `object`.
    ///
    ///```
    /// JsonFellow.makeObject([User].self, data) // returns [User] model
    /// ```
    ///
    /// > Warning: To produce an object, must conform ``Decodable``
    ///
    /// - Parameters:
    ///     - object: The expected object.
    ///     - data: expected data to decode.
    ///
    /// - Returns: Object for the given `object`.
    public static func makeObject<T: Decodable>(_ object: T.Type, _ data: Data) -> T? {
        return T.decode(data)
    }

    /// Produce the expected object for the given `object`.
    /// 
    ///```
    /// JsonFellow.make([User].self, "mockData") // returns [User] model
    /// ```
    ///
    /// > Warning: To produce an object, must conform ``Decodable``
    ///
    /// - Parameters:
    ///     - object: The expected object.
    ///     - path: json path.
    ///     - pathType: json path type. Could be saved to documents or locally dropped to folders. Default is locale.
    ///
    /// - Returns: Object for the given `object`.
    public static func make<T: Decodable>(_ object: T.Type, _ path: String, withType: PathType = .locale) -> T? {
        guard let data = dataFrom(path, withType),
              let object = T.decode(data)
        else { return nil }

        return object
    }

    // MARK: - Save

    /// Saves the json for the given `json`.
    ///
    ///```
    /// JsonFellow.save(json, "fileName") // saves the json to fileName
    /// ```
    ///
    /// > Warning: json must be ``String``
    ///
    /// - Parameters:
    ///     - json: String json of data to save.
    ///     - withName: file name to save.
    ///
    /// - Returns: Saves the given `json` to given `withName`.
    public static func save(json: String?, withName: String) {
        let filePath = filePath(withName)

        if !FileManager.default.fileExists(atPath: filePath) {
            FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
        }

        do {
            try json?.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            print("error writing to file to path: \(filePath)")
        }
    }
}
