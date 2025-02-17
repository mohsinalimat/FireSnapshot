//
// Copyright © Suguru Kishimoto. All rights reserved.
//

import Foundation
import FirebaseFirestore

public extension Snapshot {
    typealias WriteResultBlock = (Result<Void, Error>) -> Void

    func create(merge: Bool = false,
                completion: @escaping WriteResultBlock = { _ in }) {
        do {
            reference.setData(try extractWriteFieldsForCreate(), merge: merge, completion: Self.writeCompletion(completion))
        } catch {
            completion(.failure(error))
        }
    }

    func update(completion: @escaping WriteResultBlock = { _ in }) {
        do {
            reference.updateData(try extractWriteFieldsForUpdate(), completion: Self.writeCompletion(completion))
        } catch {
            completion(.failure(error))
        }
    }

    func delete(completion: @escaping WriteResultBlock = { _ in }) {
        reference.delete(completion: Self.writeCompletion(completion))
    }

    private static func writeCompletion(_ completion: @escaping WriteResultBlock) -> (Error?) -> Void {
        return { error in completion(error.map { .failure($0) } ?? .success(())) }
    }
}
