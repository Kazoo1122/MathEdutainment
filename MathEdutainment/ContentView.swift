//
//  ContentView.swift
//  MathEdutainment
//
//  Created by Kazumasa Ohira on 2022/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var fromNum = 2.0 {
        didSet {
            randomNumber()
            round = 0
            score = 0
        }
    }
    @State private var quantity = 5.0 {
        didSet {
            randomNumber()
            round = 0
            score = 0
        }
    }
    @State private var maxNum = 9
    @State private var difficult = 1.0 {
        didSet {
            randomNumber()
            round = 0
            score = 0
        }
    }
    @State private var inputNum = 0
    @State private var multipliedNum = Int.random(in: 1...9)
    @State private var round = 0
    @State private var score = 0
    @State private var showingResult = false
    @State private var resultTitle = ""
    @State private var resultText = ""
    let difficultDict = [1.0: "Easy", 2.0: "Normal", 3.0: "Hard"]
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                Form {
                    Section {
                        HStack {
                            Slider(value: $fromNum, in: 2...12, step: 1.0)
                            Text("\(fromNum.formatted())")
                        }
                    } header: {
                        Text("times table")
                    }
                    Section {
                        HStack {
                            Slider(value: $quantity, in: 5...20, step: 5.0)
                            Text("\(quantity.formatted())")
                        }
                    } header: {
                        Text("number of questions")
                    }
                    Section {
                        HStack {
                            Slider(value: $difficult, in: 1...3, step: 1.0)
                            Text("\(difficultDict[difficult] ?? "Unknown")")
                        }
                    } header: {
                        Text("difficulty")
                    }
                    if round == 0 {
                        Button("Start") { round = 1 }
                    }
                }
                if round > 0 {
                    Section {
                        HStack {
                            Spacer()
                            Spacer()
                            TextField("Your answer", value: $inputNum, format: .number)
                                .keyboardType(.decimalPad)
                                .font(.title)
                                .padding(10)
                                .background(.cyan.opacity(0.2))
                                .cornerRadius(12)
                            Spacer()
                            Spacer()
                        }

                        ZStack {
                            Rectangle()
                                .fill(.cyan)
                                .opacity(0.5)
                                .frame(width: 400, height: 200)
                                .cornerRadius(18)
                            VStack(alignment: .center) {
                                ZStack {
                                    Rectangle()
                                        .fill(.white)
                                        .opacity(0.75)
                                        .frame(width: 320, height: 100)
                                        .cornerRadius(18)
                                    Text("\(fromNum.formatted()) x \(multipliedNum) = ?")
                                        .font(.largeTitle)
                                }
                                HStack {
                                    Spacer()
                                    Text("score: \(score)")
                                    Spacer()
                                    Text("round: \(round)")
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("MathEdutainment")
            .onSubmit(submitAnswer)
            .alert(resultTitle, isPresented: $showingResult) {
                Button("OK") {
                    round += 1
                    if (round - 1) == Int(quantity) {
                        round = 0
                    } else {
                        inputNum = 0
                        randomNumber()
                    }
                }
            } message: {
                Text(resultText)
            }
        }
    }
    func submitAnswer() {
        let answerNum = Int(fromNum) * multipliedNum
        if inputNum == answerNum {
            score += 1
            resultTitle = "Correct"
        } else {
            resultTitle = "Wrong"
        }
        resultText = round == Int(quantity) ? "Game Over" : "Continue"
        showingResult = true
    }
    func randomNumber() {
        switch difficult {
            case 2.0:
                maxNum = 12
            case 3.0:
                maxNum = 24
            default:
                maxNum = 9
        }
        multipliedNum = Int.random(in: 1...maxNum)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
