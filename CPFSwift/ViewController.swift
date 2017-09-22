//
//  ViewController.swift
//  CPFSwift
//
//  Created by Marcelo Sampaio on 9/21/17.
//  Copyright © 2017 Marcelo Sampaio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var txtCpf: UITextField!
    @IBOutlet var message: UILabel!
    
    // MARK: - Properties
    var i = 0
    var firstSum = 0
    var secondSum = 0
    var firstDigit = 0
    var secondDigit = 0
    var firstDigitCheck = 0
    var secondDigitCheck = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        message.text = ""
    }

    
    // MARK: - UI Actions
    @IBAction func validateCpf(_ sender: Any) {
        message.text = ""
        if isValidCpf(txtCpf.text!) {
            print("********* OK - CPF VALIDO")
            message.text = "OK"
        }else{
            print("********* NAO OK - CPF INVALIDO")
            message.text = "Inválido"
        }
    }
    
    
    // MARK: - CPF Helper
    private func isValidCpf(_ cpf: String) -> Bool {

        // cpf length must be 11 charecters long
        if cpf.characters.count != 11 {
            return false
        }
        i = 0
        for character in cpf {
            let value = Int(character.description) ?? 0
            
            // step 1
            if i <= 8 {
                performFirstSum(value: value)
            }
            // step2
            if i <= 9 {
                performSecondSum(value: value)
            }
            //
            if i == 9 {
                firstDigitCheck = value
            }else if i == 10 {
                secondDigitCheck = value
            }
            
            print("-> \(value)")
            
            
            // digit control
            i = i + 1
        }
        
        //
        if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck)) {
            return true;
        }
        
        
        return false
    }

    // first sum
    private func performFirstSum(value: Int) {
        firstSum = firstSum + (value * (10 - i))
        
        if (firstSum % 11 < 2) {
            firstDigit = 0;
        }
        else {
            firstDigit = 11 - (firstSum % 11);
        }

    }

    // second sum
    private func performSecondSum(value: Int) {
        secondSum = secondSum + (value * (11 - i))
        
        if (secondSum % 11 < 2) {
            secondDigit = 0;
        }
        else {
            secondDigit = 11 - (secondSum % 11)
        }
        
    }
    
    // Prevent valid digits to acceptf as true
    private func isFakeCpf(_ cpf: String) -> Bool {
        
        if (cpf == "00000000000" || cpf == "11111111111" || cpf == "22222222222" || cpf == "33333333333" || cpf == "44444444444" || cpf == "55555555555" || cpf == "66666666666" || cpf == "77777777777" || cpf == "88888888888" || cpf == "99999999999") {
            return false
        }
        
        
        return true
    }
    

}

