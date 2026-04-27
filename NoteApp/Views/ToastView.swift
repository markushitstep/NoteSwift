import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
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
