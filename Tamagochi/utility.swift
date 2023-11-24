//
//  utility.swift
//  Tamagochi
//
//  Created by William Eze on 22/11/2023.
//

import Foundation

func getInt(prompt: String) -> Int {
  print(prompt)
  if let input = readLine(){
    if let integer = Int(input){
      return integer
    }
  }
  return -1
}
 
func getStr(prompt: String) -> String {
  print(prompt)
  if let input = readLine(){
    return input
  }
  return "-1"
}
 
func getDouble(prompt: String) -> Double{
  print(prompt)
  if let input = readLine(){
    if let double = Double(input){
      return double
    }
  }
  return -1.0
}

func round(_ number: Double, places decimalPlaces: Int) -> Double {
    let multiplier = pow(10.0, Double(decimalPlaces))
    return round(number * multiplier) / multiplier
}


class Tamagotchi{
    
    private var health = Double()
    private var hunger = Double()
    private var happiness = Double()
    private var discipline = Double()
    private var bowels = Double()
    private var age = Int()
    private var tiredness = Int()
    
    init(health: Double, hunger: Double, happiness: Double, discipline: Double) {
        self.health = health
        self.hunger = hunger
        self.happiness = happiness
        self.discipline = discipline
        self.bowels = 0
        self.age = 0
        self.tiredness = 0
    }
    
    func getStats() {
        print("""
              Health: \(self.health)
              Hunger: \(self.hunger)
              Happiness: \(self.happiness)
              Discipline: \(self.discipline)
              Bowels: \(self.bowels)
              Age: \(self.age)
              """)
    }
    
    func feed(){
        if self.hunger < 1{
            print("Tamagotchi is not hungry")
        }
        else{
            let foodType = getStr(prompt: "Would you like to feed Tamagotchi a meal or a snack?").lowercased()
            if foodType == "meal"{
                print("Current hunger level is \(self.hunger). After feeding a meal, new hunger level is \(self.hunger-5)")
                self.hunger -= 5
                self.bowels += 3
                self.tiredness += 1
            }
            else if foodType == "snack"{
                print("Current hunger level is \(self.hunger). After feeding a snack, new hunger level is \(self.hunger-2.5)")
                self.hunger -= 2.5
                self.bowels += 1
                self.health -= 1
                self.tiredness += 1
            }
        }
    }
    
    func sleep(){
        print("Tamagotchi has slept for 8 hours")
        self.tiredness = 0
        self.happiness += 2
        self.health += 1
        self.age += 1
    }
    
    func defecate(){
        print("Tamagotchi has fully relived itself")
        self.bowels = 0
    }
    
    func medicine(){
        if self.health <= 6{
            print("Tamagotchi's health has been restored")
            self.health = 10
        }
        else{
            print("Tamagotchi's health is fine")
        }
    }
    
    func disciplined(){
        print("Tamagotchi has been disciplined for poor behaviour")
        self.discipline += 2
    }
    
    func play(){
        let options = ["left", "right"]
        for _ in 1...5{
            let userSelection = getStr(prompt: "Is Tamagotchi going to turn left or right?")
            if userSelection == options.randomElement()! {
                print("Correct! Tamagotchi is happy")
                self.happiness += 0.5
                self.tiredness += 3
                self.hunger += 2
            }
            else{
                print("Incorrect... Tamagotchi is sad")
                self.happiness -= 0.5
                self.tiredness += 3
                self.hunger += 2
            }
        }
    }
    
    func game(){
        while true{
            print("""
            Enter the number of the command for your Tamagotchi
            1. Feed
            2. Play
            3. Sleep
            4. Defecate
            5. Take medicine
            6. See statistics
            """)
            let command = getInt(prompt: ">> ")
            
            switch command{
            case 1:
                feed()
            case 2:
                play()
            case 3:
                sleep()
            case 4:
                defecate()
            case 5:
                medicine()
            case 6:
                getStats()
            default:
                print("Invalid command given. Try again")
            }
            
            if self.age >= 10{
                print("Oh no...Tamagotchi died of old age")
                break
            }
            if self.bowels > 5 {
                print("Tamagotchi needs to defecate...now")
                self.happiness -= 2
                self.health -= 1
            }
            
            if self.happiness < 5 {
                print("Tamagotchi is depressed. If happiness reaches 0, it will die")
                if self.happiness < 1{
                    print("Tamagotchi died of depression")
                    break
                }
            }
            
            if self.tiredness > 6 {
                print("Tamagotchi needs to sleep now")
                if self.tiredness > 10{
                    print("Tamagotchi died of exhaustion")
                }
            }
        }
    }
    
}
