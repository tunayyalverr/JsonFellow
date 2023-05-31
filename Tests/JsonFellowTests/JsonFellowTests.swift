import XCTest
@testable import JsonFellow

final class JsonFellowTests: XCTestCase {
    // MARK: - Tests
    func test_dataFrom_withInvalidPath_returnsNil() {
        // Given
        let path = "invalidPath"

        // When
        let data = JsonFellow.dataFrom(path, .locale)

        // Then
        XCTAssertNil(data)
    }

    func test_makeObject_withValidData_returnsObject() {
        // Given
        guard let data = "{\"id\":1,\"name\":\"John\"}".data(using: .utf8) else { return }
        let expectedUser = TestUser(id: 1, name: "John")

        // When
        let user = JsonFellow.makeObject(TestUser.self, data)

        // Then
        XCTAssertEqual(user?.id, expectedUser.id)
        XCTAssertEqual(user?.name, expectedUser.name)
    }

    func test_makeObject_withInvalidData_returnsNil() {
        // Given
        guard let data = "{\"id\":1}".data(using: .utf8) else { return }

        // When
        let user = JsonFellow.makeObject(TestUser.self, data)

        // Then
        XCTAssertNil(user)
    }

    // TODO: Update !!
//    func test_make_withValidPath_returnsObject() {
//        // Given
//        let expectedUser = TestUser(id: 1, name: "John")
//
//        // When
//        let user = JsonFellow.make(TestUser.self, "testMockData", forBundle: Bundle.module)
//
//        // Then
//        XCTAssertEqual(user?.id, expectedUser.id)
//        XCTAssertEqual(user?.name, expectedUser.name)
//    }

    func test_make_withInvalidPath_returnsNil() {
        // Given
        let path = "invalidPath"

        // When
        let user = JsonFellow.make(TestUser.self, path)

        // Then
        XCTAssertNil(user)
    }

    func test_save_withValidJsonAndName_savesJson() {
        // Given
        let json = "{\"id\":1,\"name\":\"John\"}"
        let fileName = "testFile"

        // When
        JsonFellow.save(json: json, withName: fileName)

        // Then
        let fileManager = FileManager.default
        let filePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName + ".json")
        XCTAssertTrue(fileManager.fileExists(atPath: filePath.path))
        try? fileManager.removeItem(at: filePath)
    }

    func test_save_withNilJsonAndName_doesNotSave() {
        // Given
        let fileName = "testFile"

        // When
        JsonFellow.save(json: nil, withName: fileName)

        // Then
        let fileManager = FileManager.default
        let filePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName + ".json")
        XCTAssertFalse(fileManager.fileExists(atPath: filePath.path))
    }
}
