//
//  GameViewController.swift
//  wordle
//
//  Created by Chu Go-Go on 2022/4/5.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet var fristRoundLabel: [UILabel]!
    @IBOutlet var keyBordBT: [UIButton]!
    @IBOutlet var secRoundLabel: [UILabel]!
    @IBOutlet var thridRoundLabel: [UILabel]!
    @IBOutlet var fourRoundLabel: [UILabel]!
    @IBOutlet var fiveRoundLabel: [UILabel]!
    @IBOutlet var sixRoundLabel: [UILabel]!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var sentAnswerBT: UIButton!
    @IBOutlet weak var playAgainBT: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerArray = showAnswerWord(answer: answer.answerWord())
        sentAnswerBT.isEnabled = false
        print("答案1\(answerArray)")
        // Do any additional setup after loading the view.
    }
//    計算單字的量
    var textLabelIndex = 0
//    計算第幾輪
    var roundCount = 0
//    叫出答案題庫
    let answer = Answer()
//    猜的字(string)
    var guess = ""
// 把答案轉成[String]
    var answerArray = [String]()
//    把猜的字轉成[String]
    var guessArray = [String]()
//    計算規則、答案頁面顯示
    var resultIndex = 0
//    計算是否獲勝
    var winCount = 0
//    儲存最後結果的Emoji
    var roundText = ""
//    控制鍵盤文字的button
    @IBAction func keyBoardButton(_ sender: UIButton) {
        //                print("鍵盤\(textLabelIndex)")
//        讓打的字跑到label的func
        typeWord(button: sender)
//        如果打字滿5個
        if textLabelIndex == 5{
            for typebutton in self.keyBordBT{
//                就不能再打字
                typebutton.isEnabled = false
            }
//            滿五個就可以按送出答案的button
            sentAnswerBT.isEnabled = true
        }
//       儲存打字產生的string
        guard let guessString = sender.currentTitle else {
            return
        }
//        將字append到guess裡
        guess.append(guessString)
        //        print("加入第幾個字\(textLabelIndex)")
    }
    @IBAction func sentAnswer(_ sender: UIButton) {
//        按完送出後就讓他不能再按
        sentAnswerBT.isEnabled = false
//        按下後跑到確認題目跟答案的func
        checkAnswer()
//        更新每一輪
        updateUI()
//        print(resultLabel.text)
//        print("第\(roundCount)輪")
    }
//    刪除文字案件
    @IBAction func removeBT(_ sender: UIButton) {
//        如果當文字是空直時會跳出這個action
        if guess.isEmpty {
            return
        }
//         移調最後一個字
        guess.removeLast()
//        當字少於5個時都可以打字
        if textLabelIndex <= 5{
//            讓送出鍵不能按
            sentAnswerBT.isEnabled = false
//            把文字鍵盤打開起來
            for typebutton in self.keyBordBT{
                typebutton.isEnabled = true
            }
//            判斷第幾輪的label
            if roundCount == 0{
//                讓計算字的index -1
                textLabelIndex -= 1
//                刪掉最後的字
                fristRoundLabel[textLabelIndex].text?.removeAll()
            }else if roundCount == 1{
                textLabelIndex -= 1
                secRoundLabel[textLabelIndex].text?.removeAll()
            }else if roundCount == 2{
                textLabelIndex -= 1
                thridRoundLabel[textLabelIndex].text?.removeAll()
            }else if roundCount == 3{
                textLabelIndex -= 1
                fourRoundLabel[textLabelIndex].text?.removeAll()
            }else if roundCount == 4{
                textLabelIndex -= 1
                fiveRoundLabel[textLabelIndex].text?.removeAll()
            }else if roundCount == 5{
                textLabelIndex -= 1
                sixRoundLabel[textLabelIndex].text?.removeAll()
            }
            
        }
        //        print("刪除第一輪\(fristRoundLabel.removeLast())")
        //        print("刪除\(guess)")
        //        print("刪除第幾個字\(textLabelIndex)")
    }
//    顯示規則
    @IBAction func ruleButton(_ sender: UIButton) {
//        按一下加一
        resultIndex += 1
//        等於一把隱藏的view跟label都顯示
        if resultIndex == 1{
//            顯示規則
            resultView.isHidden = false
            resultLabel.isHidden = false
            resultTitleLabel.isHidden = false
            playAgainBT.isHidden = true
            resultTitleLabel.text = "規則"
//            設定字體
            resultLabel.font = UIFont.systemFont(ofSize: 15)
//            設定置中
            resultLabel.contentMode = .center
//            規則
            resultLabel.text = "Wordle要怎麼玩？\n其實Wordle是一款拼字遊戲，只要會打英文就可以玩了！\nWordle的謎題玩法有點像猜數字遊戲 1A2B，遊戲的答案是五個字母的英文單字，需要在六次以內猜中即可獲勝。\n玩家可以先輸入一個五個字母的英文字，遊戲會用顏色來提示：\n灰色：答案中沒有該字母。\n黃色：答案中有該字母，但位置不對。\n綠色：猜對字母及位置。\n範例：🟩⬛️🟧🟧⬛️\n為第一個字母對，第二個不對，\n三四字對位置不對，第五字不對。"
//            不等於1時
        }else{
//            歸零
            resultIndex = 0
//            隱藏規則
            resultLabel.isHidden = true
            resultView.isHidden = true
            resultTitleLabel.isHidden = true
        }
    }
//    再玩一次
    @IBAction func playAgainButton(_ sender: UIButton) {
//        重置遊戲
        resetGame()
    }
//    顯示猜的文字
    func showGuessWord(word: String) -> [String]{
//        儲存每個文字成["s","t","r","i","n","g"]
        let guessWordToArray = word.map({i -> String in String(i)})
        return guessWordToArray
    }
//    顯示答案文字
    func showAnswerWord(answer: String) -> [String]{
        //        儲存每個文字成["s","t","r","i","n","g"]
        let answerToArray = answer.map({a -> String in String(a)})
        
        //        print(guess)
        return answerToArray
    }
//  檢查答案
    func checkAnswer(){
//        把回傳的猜字做成一個常數
        let guessWord = showGuessWord(word: guess)
//用for-in跑五次來比較兩邊的字是否一樣
        for i in 0...4{
//            如果猜的跟答案一樣就會回傳，第0輪的時候
            if guessWord[i] == answerArray[i], roundCount == 0{
//                讓一樣的字的Label變色成綠色
                fristRoundLabel[i].backgroundColor = .green
//                回傳鍵盤的字也變綠色
                changeKeyBoardColor(word: guessWord[i], color: .green)
//                回傳綠色🟩Emoji
                checkGameResult(result: .greenEmoji)
//                當答案裡的字跟你猜的字有相關的，第0輪的時候
            }else if answerArray.contains(guessWord[i]), roundCount == 0{
//                 讓字的Label變色成橘色
                fristRoundLabel[i].backgroundColor = .orange
//                回傳鍵盤的字也變綠色
                changeKeyBoardColor(word: guessWord[i], color: .orange)
                //                回傳橘色🟧Emoji
                checkGameResult(result: .orangeEmoji)
            }else if guessWord[i] == answerArray[i], roundCount == 1{
                secRoundLabel[i].backgroundColor = .green
                changeKeyBoardColor(word: guessWord[i], color: .green)
                checkGameResult(result: .greenEmoji)
            }else if answerArray.contains(guessWord[i]), roundCount == 1{
                secRoundLabel[i].backgroundColor = .orange
                changeKeyBoardColor(word: guessWord[i], color: .orange)
                checkGameResult(result: .orangeEmoji)
                //                print("\(guessWord[i])有這個字")
            }else if guessWord[i] == answerArray[i], roundCount == 2{
                thridRoundLabel[i].backgroundColor = .green
                changeKeyBoardColor(word: guessWord[i], color: .green)
                checkGameResult(result: .greenEmoji)
                
                //                    print("\(guessWord[i])一樣")
            }else if answerArray.contains(guessWord[i]), roundCount == 2{
                thridRoundLabel[i].backgroundColor = .orange
                changeKeyBoardColor(word: guessWord[i], color: .orange)
                checkGameResult(result: .orangeEmoji)
                //                    print("\(guessWord[i])有這個字")
            }else if guessWord[i] == answerArray[i], roundCount == 3{
                fourRoundLabel[i].backgroundColor = .green
                changeKeyBoardColor(word: guessWord[i], color: .green)
                checkGameResult(result: .greenEmoji)
                //                    print("\(guessWord[i])一樣")
            }else if answerArray.contains(guessWord[i]), roundCount == 3{
                fourRoundLabel[i].backgroundColor = .orange
                changeKeyBoardColor(word: guessWord[i], color: .orange)
                checkGameResult(result: .orangeEmoji)
                //                    print("\(guessWord[i])有這個字")
            }else if guessWord[i] == answerArray[i], roundCount == 4{
                fiveRoundLabel[i].backgroundColor = .green
                changeKeyBoardColor(word: guessWord[i], color: .green)
                checkGameResult(result: .greenEmoji)
                //                    print("\(guessWord[i])一樣")
            }else if answerArray.contains(guessWord[i]), roundCount == 4{
                fiveRoundLabel[i].backgroundColor = .orange
                changeKeyBoardColor(word: guessWord[i], color: .orange)
                checkGameResult(result: .orangeEmoji)
                //                    print("\(guessWord[i])有這個字")
            }else if guessWord[i] == answerArray[i], roundCount == 5{
                sixRoundLabel[i].backgroundColor = .green
                changeKeyBoardColor(word: guessWord[i], color: .green)
                checkGameResult(result: .greenEmoji)
                
                //                    print("\(guessWord[i])一樣")
            }else if answerArray.contains(guessWord[i]), roundCount == 5{
                sixRoundLabel[i].backgroundColor = .orange
                changeKeyBoardColor(word: guessWord[i], color: .orange)
                checkGameResult(result: .orangeEmoji)
                //                    print("\(guessWord[i])有這個字")
            }else{
                //                    print("都沒有")
//                都沒有鍵盤就變深灰色
                changeKeyBoardColor(word: guessWord[i], color: .darkGray)
//                回傳⬛️Emoji
                checkGameResult(result: .darkGrayEmoji)
            }
        }
//        如果5個都一樣判斷勝利
        if winCount == 5 {
            resultTitleLabel.isHidden = false
            resultTitleLabel.textColor = .green
            resultTitleLabel.text = "猜對囉！"
            resultView.isHidden = false
            resultLabel.isHidden = false
            resultLabel.contentMode = .center
            resultLabel.font = UIFont.systemFont(ofSize: 36)
            playAgainBT.isHidden = false
//            如果第6輪完都不一樣判斷失敗
        } else if roundCount == 5 , winCount != 5{
            resultTitleLabel.isHidden = false
            resultTitleLabel.textColor = .red
            resultTitleLabel.text = "你輸了！"
            resultView.isHidden = false
            resultLabel.isHidden = false
            resultLabel.contentMode = .center
            resultLabel.font = UIFont.systemFont(ofSize: 38)
            playAgainBT.isHidden = false
        }else {
//            還沒結束時
            winCount = 0
            resultTitleLabel.isHidden = true
            resultView.isHidden = true
            playAgainBT.isHidden = true
        }
        print("winCount\(winCount)")
//        結束時加1輪
        roundCount += 1
        
        //        print("答案2\(answerArray)")
    }
//    打字的鍵盤應對第幾輪的Label
    func typeWord(button: UIButton){
//        如果是第1輪
        if roundCount == 0 {
//            就會等於第一排的Label顯示，字是按照Button上的Title
            fristRoundLabel[textLabelIndex].text = button.currentTitle
//            第一個Label跑完就會跑到第二個Label
            textLabelIndex += 1
        }else if roundCount == 1{
            secRoundLabel[textLabelIndex].text = button.currentTitle
            textLabelIndex += 1
        }else if roundCount == 2{
            thridRoundLabel[textLabelIndex].text = button.currentTitle
            textLabelIndex += 1
        }else if roundCount == 3{
            fourRoundLabel[textLabelIndex].text = button.currentTitle
            textLabelIndex += 1
        }else if roundCount == 4{
            fiveRoundLabel[textLabelIndex].text = button.currentTitle
            textLabelIndex += 1
        }else if roundCount == 5{
            sixRoundLabel[textLabelIndex].text = button.currentTitle
            textLabelIndex += 1
//            如果到第6輪
        }else if roundCount == 6{
//            回到第一輪
            roundCount = 0
        }
        //        print("typeWord\(textLabelIndex)")
    }
//    跑完一輪的顯示後讓猜的字變成空值
    func updateUI(){
//        讓儲存猜的字變成空值
        guess = ""
//        讓儲存猜的字變成空值
        guessArray.removeAll()
//        讓array從第一個開始跑
        textLabelIndex = 0
//        打開每個按鍵
        for typebutton in self.keyBordBT{
            typebutton.isEnabled = true
        }
    }
//    變換文字鍵盤的顏色
    func changeKeyBoardColor(word: String, color: UIColor){
//        先跑一個整個鍵盤的回圈
        for button in keyBordBT{
//            當有遇到跟猜中的字一樣的時候
            if button.titleLabel?.text == word {
//                變成你想要的顏色
                button.backgroundColor = color
            }
        }
    }
//    回傳結果的Func
    func checkGameResult(result: gameResult)  {
//       用switch Case跑出當遇到每個結果時會做的事情
        switch result {
        case .greenEmoji:
//            答對時 回傳綠色emoji以及+1的勝利
            winCount += 1
//            讓儲存結果的roundText疊加
            roundText = roundText + result.result
        case .orangeEmoji:
//            答對字時回傳橘色emoji以及把勝利歸0
            winCount = 0
//            讓儲存結果的roundText疊加
            roundText = roundText + result.result
        case .darkGrayEmoji:
//            都沒有答對時回傳黑色emoji以及把勝利歸0
            winCount = 0
//            讓儲存結果的roundText疊加
            roundText = roundText + result.result
        }
//          跑完之後結果會顯示在resultLabel上
        resultLabel.text! = roundText
    }
    
//    再來一局時歸零儲存的值
    func resetGame(){
        sentAnswerBT.isEnabled = false
        playAgainBT.isHidden = true
        resultLabel.isHidden = true
        resultView.isHidden = true
        resultTitleLabel.isHidden = true
        resultIndex = 0
        winCount = 0
        resultIndex = 0
        textLabelIndex = 0
        roundCount = 0
        roundText = ""
        guess = ""
//        再產生一個新的題目
        answerArray = showAnswerWord(answer: answer.answerWord())
//        讓每一個按鍵變回原本的顏色
        for buttons in keyBordBT{
            buttons.backgroundColor = .systemGray
        }
//        讓顯示文字的label變回原本的顏色以及清空裡面的內容
        for label in fristRoundLabel{
            label.text = ""
            label.backgroundColor = .darkGray
        }
        for label in secRoundLabel{
            label.text = ""
            label.backgroundColor = .darkGray
        }
        for label in thridRoundLabel{
            label.text = ""
            label.backgroundColor = .darkGray
        }
        for label in fourRoundLabel{
            label.text = ""
            label.backgroundColor = .darkGray
        }
        for label in fiveRoundLabel{
            label.text = ""
            label.backgroundColor = .darkGray
        }
        for label in sixRoundLabel{
            label.text = ""
            label.backgroundColor = .darkGray
        }
    }
    
//    func showAlert(title: String, message: String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "確定", style: .default)
//        alert.addAction(alertAction)
//        present(alert, animated: true, completion: nil)
//    }
}

