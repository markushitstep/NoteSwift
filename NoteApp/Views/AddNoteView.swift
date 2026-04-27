import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""
    @State private var showToast = false
    @State private var errorMessage = ""
    @State private var isLoading = false

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
                    Task {
                        await validateAndSave()
                    }
                } label: {
                    Text(isLoading ? "Saving..." : "Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isLoading ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Add Note")

            if showToast {
                ToastView(message: errorMessage)
            }
        }
        .animation(.easeInOut, value: showToast)
    }

    private func validateAndSave() async {
        let value = trimmedText

        if let error = NoteValidator.validate(value) {
            showError(error)
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let weather = try await WeatherService().fetchWeather()

            let newNote = Note(
                text: value,
                date: Date(),
                temperature: weather.temperature,
                weatherDescription: weather.description
            )

            onSave(newNote)
            dismiss()
        } catch WeatherServiceError.unauthorized {
            showError("Weather API key is not active or invalid.")
        } catch WeatherServiceError.invalidURL {
            showError("Weather request URL is invalid.")
        } catch WeatherServiceError.serverError {
            showError("Weather server error. Try again later.")
        } catch {
            showError("Failed to load weather. Check your internet connection.")
        }
    }
}

#Preview {
    NavigationStack {
        AddNoteView { _ in }
    }
}
