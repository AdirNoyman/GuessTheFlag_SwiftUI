//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by אדיר נוימן on 14/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia","France","Germany", "Ireland","Italy","Nigeria","Poland","Russia", "Spain","UK","US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    

     var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 30) {
                
                VStack {
                    
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer]).font(.largeTitle).fontWeight(.black)
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        
                        self.flagTapped(number)
                        
                    }) {
                        
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            
                            .overlay(Capsule()
                            .stroke(Color.black,lineWidth:1))
                            .shadow(color:.black,radius: 2 )
                    }
                    
                }
                Spacer()
            }
        }
        
        .alert(isPresented: $showingScore) {
            
            Alert(title: Text(scoreTitle), message: Text("You scored \(score) points"), dismissButton: .default(Text("Continue")) {
                
                self.askQuestion()
            })
        }
       
     }
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            
            scoreTitle = "Correct!"
            score += 1
            
        } else {
            
            scoreTitle = "Wrong!"
            if (self.score <= 0) {
                
                score = 0
            } else {
                
                score -= 1
            }
             
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
