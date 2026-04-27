import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""
    @State private var showToast = false
    @State private var errorMessage = ""

    var onSave: (Note) -> Void

    private let minLength = 3
    private let maxLength = 120

    private var trimmedText: String {
        text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var textCount: Int {
        trimmedText.count
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showToast = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showToast = false
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 16) {
                TextField("Enter note", text: $text)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(errorMessage.isEmpty ? Color.gray.opacity(0.4) : Color.red, lineWidth: 1)
                    )
                    .onChange(of: text) { errorMessage = "" }

                Button {
                    validateAndSave()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Add Note")

            if showToast {
                Text(errorMessage)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: showToast)
    }

    private func validateAndSave() {
        let value = trimmedText

        if value.isEmpty {
            showError("Note cannot be empty.")
            return
        }

        if value.count < 3 {
            showError("Note must be at least 3 characters.")
            return
        }

        if value.count > 120 {
            showError("Note must be no longer than 120 characters.")
            return
        }

        if value.rangeOfCharacter(from: .decimalDigits) != nil {
            showError("Numbers are not allowed.")
            return
        }

        let allowedPattern = #"^[A-Za-zА-Яа-яЁёІіЇїЄєҐґ\s\.,!\?\-'"()]+$"#

        if value.range(of: allowedPattern, options: .regularExpression) == nil {
            showError("Only letters, spaces, and basic punctuation are allowed.")
            return
        }

        let newNote = Note(
            text: value,
            date: Date(),
            temperature: Double.random(in: 15...25)
        )

        onSave(newNote)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        AddNoteView { _ in }
    }
}
