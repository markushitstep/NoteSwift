import SwiftUI

struct ContentView: View {
    private let storageService = StorageService()
    @State private var notes: [Note] = []
    
    var body: some View {
        NavigationStack {
            List(notes) { note in
                NavigationLink {
                        NoteDetailView(note: note)
                    } label: {
                        NoteView(
                            text: note.text,
                            date: note.date,
                            temperature: note.temperature
                        )
                    }
            }
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    AddNoteView { newNote in
                        notes.append(newNote)
                        storageService.save(notes)
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            .onAppear {
                notes = storageService.load()
            }
        }
    }
}

#Preview {
    ContentView()
}
