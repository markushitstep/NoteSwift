import SwiftUI

struct NoteDetailView: View {
    let note: Note

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.text)
                .font(.title)
                .bold()

            Text(note.date, style: .date)
                .font(.headline)

            HStack {
                Image(systemName: "cloud")
                Text(note.weatherDescription)
                Text("•")
                Text("\(note.temperature, specifier: "%.1f")°C")
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
        .navigationTitle("Note Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NoteDetailView(
            note: Note(
                text: "Preview",
                date: Date(),
                temperature: 18,
                weatherDescription: "Cloudy"
            )
        )
    }
}
