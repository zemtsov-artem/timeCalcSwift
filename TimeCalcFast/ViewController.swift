//
//  ViewController.swift
//  TimeCalcFast
//
//  Created by артем on 06.11.16.
//  Copyright © 2016 артем. All rights reserved.
//  End-startTime
//  start-endTime it

import UIKit

func checkData(_ value:Int,_ min:Int,_ max:Int)->Bool{
    if (value < min) {
        return false
    }else {
        if (value > max) {
            return false
        }
        else {
            return true
        }
    }
}

struct Time {
    var Hour:Int;
    var Minutes:Int;
    init() {
        Hour=0;
        Minutes=0;
    }
    init(_ hour:Int,_ minutes:Int) {
        if( checkData(hour,0,23) && checkData(minutes, 0, 59) ){
            Hour = hour
            Minutes = minutes
        }
        else {
            Hour=0;
            Minutes=0;
            //exit(-1);
        }
    }
}

func - (_ firstValue:Time,_ secondValue:Time) ->Time {
    var resH:Int;
    var resM:Int;
    resH = firstValue.Hour - secondValue.Hour;
    resM = firstValue.Minutes - secondValue.Minutes;
    if resM < 0 {
        resH = resH-1
        resM = resM + 60
    }
    
    if resH < 0 {
        resH = resH + 24
    }
    
    let resValue = Time(resH,resM)
    return resValue
}

class ViewController: UIViewController {
    //res
    @IBOutlet weak var HoursRes: UILabel!
    @IBOutlet weak var MinutesRes: UILabel!
    //start
    @IBOutlet weak var HoursStart: UITextField!
    @IBOutlet weak var MinutesStart: UITextField!
    //finish
    @IBOutlet weak var HoursEnd: UITextField!
    @IBOutlet weak var MinutesEnd: UITextField!
    //checks
    func checkTime(_ hour:Int,_ min:Int)->Bool {
        if checkData(hour, 0, 23) && checkData(min, 0, 59) {
            return true;
        } else {
            return false;
        }
    }
    
    func checkDataValue(_ hour:String,_ min:String) -> Bool {
        let checkH:Int? = Int(hour)
        let checkM:Int? = Int(min)
        if (checkH != nil) && (checkM != nil) && checkTime(Int(hour)!,Int(min)! ) {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func MakeCalc(_ sender: Any) {
        //return colors to white
        HoursEnd.backgroundColor = UIColor.white
        HoursStart.backgroundColor = UIColor.white
        MinutesEnd.backgroundColor = UIColor.white
        MinutesStart.backgroundColor = UIColor.white
        if (checkDataValue(HoursStart.text!,MinutesStart.text! ) &&
            checkDataValue(HoursEnd.text!,MinutesEnd.text! ) ) {
                let start  = Time(Int(HoursStart.text!)!,Int(MinutesStart.text!)! )
                let finish = Time(Int(HoursEnd.text!)!  ,Int(MinutesEnd.text!)! )
                let result = start - finish
                MinutesRes.text = String(result.Minutes)
                HoursRes.text = String(result.Hour)
        }
        else {
            MinutesRes.text = "err"
            HoursRes.text = "err"
            // Incorrect Start Value
                if !checkData(Int(HoursStart.text!)!,0,23) {
                    HoursStart.backgroundColor = UIColor.red
                }
                if !checkData(Int(MinutesStart.text!)!,0,59) {
                    MinutesStart.backgroundColor = UIColor.red
                }
            // Incorrect End Value
                if !checkData(Int(HoursEnd.text!)!,0,23) {
                    HoursEnd.backgroundColor = UIColor.red
                }
                if !checkData(Int(MinutesEnd.text!)!,0,59) {
                    MinutesEnd.backgroundColor = UIColor.red
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
}




