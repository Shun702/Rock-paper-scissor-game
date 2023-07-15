//
//  ContentView.swift
//  Rock,paper,scissor brain game
//
//  Created by Shun Le Yi Mon on 08/07/2023.
//

import SwiftUI

struct ContentView: View {
    private var moves = ["Rock ✊", "Paper ✋", "Scissors ✌️"]
    @State private var gameGoal = ["Beat", "Lose"]
    @State private var score = 0
    @State private var gameNum = 0
    @State private var goalSelection = Int.random(in: 0...1)
    @State private var moveSelection = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showScore = false
    @State private var endgame = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.0, green: 0.4, blue: 0.7), location: 0.3), .init(color: Color(red: 0.5, green: 0.3, blue:0.7), location: 0.3),], center: .top, startRadius: 150, endRadius: 600).ignoresSafeArea()
            VStack {
                Spacer()
                Spacer()
                Text("Choose the correct move").font(.title.weight(.bold)).foregroundColor(.white)
                VStack (spacing: 30){
                    Text("Your Goal is to ").foregroundStyle(.secondary).font(.title2.weight(.heavy))
                    HStack{
                        Text(gameGoal[goalSelection]).font(.largeTitle.weight(.semibold))
                        Text (moves[moveSelection]).font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) {
                        number in Button {
                            moveTapped(number)
                        } label: {
                            Text(moves[number]).font(.title)
                        }
                    }
                }.frame(maxWidth: .infinity).padding(.vertical, 20).background(.regularMaterial).clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                HStack{
                    Text("Socre: ").foregroundColor(.white).font(.title.bold())
                    Text(score, format: .number).foregroundColor(.white).font(.title.bold())
                }
                Spacer()
                
            }.alert(scoreTitle, isPresented: $showScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }.alert(scoreTitle, isPresented: $endgame) {
                Button("New Game", action: createNewGame)
            } message: {
                Text("End of the game. You got \(score) / 10.")
            }
        }
    }
    func moveTapped(_ number: Int) {
        // to 'Beat' the game
        if goalSelection == 0 {
            if  (moveSelection == 0 && number == 1) || (moveSelection == 1 && number == 2) || (moveSelection == 2 && number == 0){
                scoreTitle = "Correct"
                addScore()
            }
            else {
                scoreTitle = "Incorrect"
            }
        }// to lose the game
        else if goalSelection == 1 {
            if (moveSelection == 0 && number == 2) || (moveSelection == 1 && number == 0) || (moveSelection == 2 && number == 1){
                scoreTitle = "Correct ✅"
                addScore()
            }
            else {
                scoreTitle = "Incorrect ❌"
            }
        }
        showScore = true
        numOfGame()
    }
    
    func numOfGame() {
        gameNum = gameNum + 1
        if gameNum >= 10 {
            endgame = true
        }
    }
    func addScore() {
        score = score + 1
    }
    func askQuestion() {
        moveSelection = Int.random(in: 0...2)
        goalSelection = Int.random(in: 0...1)
        
        }
    func createNewGame(){
        gameNum = 0
        score = 0
        endgame = false
        askQuestion()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
