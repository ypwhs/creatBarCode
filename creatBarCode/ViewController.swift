//
//  ViewController.swift
//  creatBarCode
//
//  Created by 杨培文 on 15/3/13.
//  Copyright (c) 2015年 杨培文. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var Aji = ["0001101", "0011001", "0010011", "0111101", "0100011",
        "0110001" ,"0101111", "0111011", "0110111", "0001011"]
    var Bji = ["0100111", "0110011", "0011011", "0100001", "0011101",
        "0111001" ,"0000101", "0010001", "0001001", "0010111"]
    var Cji = ["1110010", "1100110", "1101100", "1000010", "1011100",
        "1001110" ,"1010000", "1000100", "1001000", "1110100"]
    var start = "101"
    var fenge = "01010"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var numbertext: UITextField!
    @IBOutlet weak var outtext: UITextView!
    @IBAction func creat(sender: AnyObject) {
        var mynumber = numbertext.text
        
        if countElements(mynumber) != 11{
            outtext.text = "长度有误"
            println(mynumber)
        }else{
            var a = [unichar](count:11,repeatedValue:0x0)
            (mynumber as NSString).getCharacters(&a, range: NSRange(location: 0,length: 11))
            var numbers = [0]
            for i in 0..<11{
                numbers += [Int(a[10-i] - 48)]
            }
            numbers += [6]
            
            println(a)
            
            var text = "开始生成\n目标数字:6"+numbertext.text
            
            //生成检验码
            var c1 = numbers[12]+numbers[10]+numbers[8]
            c1+=numbers[6]+numbers[4]+numbers[2]
            var c2 = numbers[11]+numbers[9]+numbers[7]
            c2+=numbers[5]+numbers[3]+numbers[1]
            var verify = 10-(c1 + c2*3)%10
            if verify == 10{
                verify = 0
            }
            println(verify)
            numbers[0] = verify
            text += String(verify) + "\n"
            
            //生成条码
            var barcode = start
            barcode += Aji[numbers[11]]
            barcode += Bji[numbers[10]]
            barcode += Bji[numbers[9]]
            barcode += Bji[numbers[8]]
            barcode += Aji[numbers[7]]
            barcode += Aji[numbers[6]]
            barcode += fenge
            barcode += Cji[numbers[5]]
            barcode += Cji[numbers[4]]
            barcode += Cji[numbers[3]]
            barcode += Cji[numbers[2]]
            barcode += Cji[numbers[1]]
            barcode += Cji[numbers[0]]
            barcode += start
            
            text += "编码后:\n" + start + " "
            text += Aji[numbers[11]] + " "
            text += Bji[numbers[10]] + " "
            text += Bji[numbers[9]] + " "
            text += Bji[numbers[8]] + " "
            text += Aji[numbers[7]] + " "
            text += Aji[numbers[6]] + " "
            text += fenge + " "
            text += Cji[numbers[5]] + " "
            text += Cji[numbers[4]] + " "
            text += Cji[numbers[3]] + " "
            text += Cji[numbers[2]] + " "
            text += Cji[numbers[1]] + " "
            text += Cji[numbers[0]] + " "
            text += start + "\n"
            
            outtext.text = text
            
            //开始画图
            var x:CGFloat = 0
            bar.image = UIImage()
            var context = UIGraphicsGetCurrentContext()
            UIGraphicsBeginImageContext(bar.frame.size);
            bar.image?.drawInRect(CGRectMake(0, 0, bar.frame.size.width, bar.frame.size.height))
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
            CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), true);
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0); //颜色
            CGContextBeginPath(UIGraphicsGetCurrentContext());
            
            for i in barcode{
                if i == "1"{
                    var xx = x*2+10
                    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), xx, 0);//起点
                    if (x<3)|((x>6*7+3)&(x<6*7+3+5))|(x>12*7+5+2){
                        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), xx, 110);//终点
                    }else{
                        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), xx, 100);//终点
                    }
                    CGContextStrokePath(UIGraphicsGetCurrentContext());
                }
                x += 1
            }
            bar.image=UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            //修改下面的文字
            var c = "6   "
            c += String(numbers[11])+" "
            c += String(numbers[10])+" "
            c += String(numbers[9])+" "
            c += String(numbers[8])+" "
            c += String(numbers[7])+" "
            c += String(numbers[6])+" "
            c += " "
            c += String(numbers[5])+" "
            c += String(numbers[4])+" "
            c += String(numbers[3])+" "
            c += String(numbers[2])+" "
            c += String(numbers[1])+" "
            c += String(numbers[0])+" "
            codenumber.text = c
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        numbertext.resignFirstResponder()
    }
    
    @IBOutlet weak var bar: UIImageView!
    @IBOutlet weak var codenumber: UILabel!
    

}

