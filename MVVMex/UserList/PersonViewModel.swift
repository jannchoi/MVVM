//
//  PersonViewModel.swift
//  MVVMex
//
//  Created by 최정안 on 2/5/25.
//

import Foundation
class PersonViewModel {
    
    let navigationTitle = "Person List"
    let resetTitle = "리셋 버튼"
    let loadTitle = "로드 버튼"
    
    var people: Observable<[Person]> = Observable([])
    
    var inputLoadButtonTapped: Observable<Void> = Observable(())
    var inputResetButtonTapped: Observable<Void> = Observable(())
    var inputPlusButtonTapped: Observable<Void> = Observable(())
    
    init() {
        inputLoadButtonTapped.lazyBind { _ in
            self.people.value = self.generateRandomPeople()
        }
        inputResetButtonTapped.lazyBind{ _ in
            self.people.value.removeAll()
        }
        inputPlusButtonTapped.lazyBind { _ in
            self.people.value.append(self.generateRandomPeople().randomElement() ?? Person(name: "James", age: Int.random(in: 20...70)))
        }
    }
    private func generateRandomPeople() -> [Person] {
        return [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
}
