import Foundation

struct Note: Identifiable {
    let id = UUID()
    let text: String
    let date: Date
    let temperature: Double
}
