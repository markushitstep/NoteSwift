import Foundation

final class StorageService {
    private let notesKey = "saved_notes"

    func save(_ notes: [Note]) {
        do {
            let data = try JSONEncoder().encode(notes)
            UserDefaults.standard.set(data, forKey: notesKey)
        } catch {
            print("Failed to save notes:", error)
        }
    }

    func load() -> [Note] {
        guard let data = UserDefaults.standard.data(forKey: notesKey) else {
            return []
        }

        do {
            return try JSONDecoder().decode([Note].self, from: data)
        } catch {
            print("Failed to load notes:", error)
            return []
        }
    }
}
