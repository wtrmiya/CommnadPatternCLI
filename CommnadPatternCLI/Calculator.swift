//
//  Calculator.swift
//  CommnadPatternCLI
//
//  Created by Wataru Miyakoshi on 2022/04/06.
//

import Foundation

class Calculator {
    private(set) var total = 0
    private var history = [Command]()
    
    // 実行するたびに操作を打ち消すコマンドをリストに追加していくのが肝
    func add(_ amount: Int) {
        addUndoCommand(method: Calculator.subtract, amount: amount)
        total += amount
    }
    
    func subtract(_ amount: Int) {
        addUndoCommand(method: Calculator.add, amount: amount)
        total -= amount
    }
    
    func multiply(_ amount: Int) {
        addUndoCommand(method: Calculator.divide, amount: amount)
        total *= amount
    }
    
    func divide(_ amount: Int) {
        addUndoCommand(method: Calculator.multiply, amount: amount)
        total = total / amount
    }
    
    // 引数の説明、というかポイントを整理する。
    // 普通、class Calculatorのインスタンスメソッドadd(_:Int) -> Voidは
    // 1. Calculatorクラスのインスタンスcalcを作成
    // 2. calc.add(_:) を実行
    // の順序で呼び出す。
    // しかし、以下の呼び出し方でも実行できる
    // 1. Calculatorクラスのインスタンスcalcを作成
    // 2. Calculator.add(calc) のように, あたかもクラスメソッドのように表記されたメソッドの引数にインスタンスを設定。
    //   これで (Int) -> Void のクロージャを生成できる。
    //   let closureToExecute = Calculator.add(calc) のように変数で受け止めるようにする
    // 3. クロージャを実行 closureToExecute(_:Int)
    // これは以下のような記法にもまとめられる。
    // add(calc)(_:Int)
    private func addUndoCommand( method: @escaping ((Calculator) -> ((Int) -> Void)), amount: Int) {
        self.history.append(GenericCommand<Calculator>.createCommand(
            receiver: self,
            instructions: { calc in
                method(calc)(amount)
                
                // 以下の記載方法もあり。
                // let closureToExecute = method(calc)
                // closureToExecute(amount)
            }))
    }
    
    func undo() {
        if self.history.count > 0 {
            self.history.removeLast().execute()
            // 暫定措置: 打ち消すためのコマンドを実行すると、historyに追加されてしまう。
            self.history.removeLast()
        }
    }
}
