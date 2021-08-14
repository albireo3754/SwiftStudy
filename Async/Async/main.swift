//
//  main.swift
//  Async
//
//  Created by 윤상진 on 2021/08/14.
//

import Foundation

print("Hello, World!")

// 스위프트 비동기 학습
// GCD를 이용하면, JS의 Promise는 쉽게 구현할 수 있지만 어떻게해야 async await를
// 직접 구현 해볼 수 있을까?

let q = DispatchQueue(label: "async test")
//q.sync {
//    for i in 1...1000 {
//        print("\(i) is async")
//    }
//}
//for i in 1...1000 {
//    print("\(i) is sync")
//}
// 이 경우는 사실 쉽게 sync async를 받을 수 있다. 하지만 네트워크 처리중 애초에 비동기로 처리되는 로직이 있을때 그걸 다시 sync하게 만들어서 결과를 출력받을 순 없을까?
// https://devmjun.github.io/archive/02-DispatchGroup

let group = DispatchGroup()
func async() {
    group.enter()
//    q.async(group: group) {
    q.async {
        for i in 1...1000 {
            print("\(i) is async")
        }
        group.leave()
    }
}
q.sync {
    async()
    print("3")
}

//print(group.())
//group.wait(timeout: .distantFuture)
group.notify(queue: q) {
    print("완료")
}
for i in 1...10000 {
    print("\(i) is sync")
}

// 어쨋든 네트워크도 완료 동작이 있을거고, 완료 동작이 완료되기전까지 어떤 루틴을 걸어두고 dispatchGroup을 활용하면 될 것 같다.
RunLoop.current.run()

