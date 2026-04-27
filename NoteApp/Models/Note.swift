import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
    let date: Date
    let temperature: Double
    let weatherDescription: String

    init(
        id: UUID = UUID(),
        text: String,
        date: Date,
        temperature: Double,
        weatherDescription: String
    ) {
        self.id = id
        self.text = text
        self.date = date
        self.temperature = temperature
        self.weatherDescription = weatherDescription
    }
}
