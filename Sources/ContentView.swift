import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var timeLeft = 20
    @State private var playing = false
    @State private var pos = CGPoint(x: 150, y: 300)
    @State private var timer: Timer?

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    Text("Score: \(score)   Time: \(timeLeft)")
                        .font(.title).bold().foregroundColor(.white)
                        .padding(.top, 60)
                    Spacer()
                }
                if playing {
                    Circle().fill(Color.orange)
                        .frame(width: 70, height: 70)
                        .position(pos)
                        .onTapGesture {
                            score += 1
                            pos = CGPoint(x: .random(in: 50...(geo.size.width - 50)),
                                          y: .random(in: 150...(geo.size.height - 80)))
                        }
                } else {
                    VStack(spacing: 20) {
                        Text(score == 0 ? "Tap the circle!" : "Game Over! Score: \(score)")
                            .font(.title2).foregroundColor(.white)
                        Button("Start") { start() }
                            .font(.title).padding(.horizontal, 40).padding(.vertical, 12)
                            .background(Color.green).foregroundColor(.white).cornerRadius(12)
                    }
                }
            }
        }
    }

    func start() {
        score = 0; timeLeft = 20; playing = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            timeLeft -= 1
            if timeLeft <= 0 { t.invalidate(); playing = false }
        }
    }
}
