import SwiftUI

struct NoteView: View {
    let text: String
    let date: Date
    let temperature: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
                .font(.title2)
                .bold()
            
            Text(date, style: .date)
                .font(.headline)
            
            HStack {
                Text("\(temperature, specifier: "%.1f")°C")
            }
            .font(.headline)
            
        }
        .padding(.vertical, 4)
    }
}
