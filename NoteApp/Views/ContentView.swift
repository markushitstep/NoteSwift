import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = [
        Note(text: "Run in the park", date: Date(), temperature: 18),
        Note(text: "Go to work", date: Date(), temperature: 20),
        Note(text: "Evening walk", date: Date(), temperature: 16)
    ]
    
    var body: some View {
        NavigationStack {
            List(notes) { note in
                VStack(alignment: .leading, spacing: 8) {
                    Text(note.text)
                        .font(.title)

                Text(note.date, style: .date)
                    .font(.headline)
                
                HStack {
                    Image(systemName: "cloud")
                    Text("\(note.temperature, specifier: "%.1f")°C")
                }
                .font(.headline)
                    
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Notes")
            .toolbar {
                NavigationLink {
                    AddNoteView { newNote in
                        notes.append(newNote)
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
