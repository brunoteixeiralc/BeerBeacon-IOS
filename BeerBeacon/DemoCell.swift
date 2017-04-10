//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import UIKit
import FoldingCell
import YBAlertController
import SCLAlertView

class DemoCell: FoldingCell {
  
  @IBOutlet weak var closeNumberLabel: UILabel!
  @IBOutlet weak var openNumberLabel: UILabel!
  @IBOutlet weak var option1: UISwitch!
  @IBOutlet weak var option2: UISwitch!
    
  var number: Int = 0 {
    didSet {
      closeNumberLabel.text = String(number + 1)
      openNumberLabel.text = "Tap \(String(number + 1))"
    }
  }
  override func awakeFromNib() {
    
    foregroundView.layer.cornerRadius = 10
    foregroundView.layer.masksToBounds = true
    
    option1.addTarget(self, action: #selector(DemoCell.stateChangedOption1), for: UIControlEvents.valueChanged)
    option2.addTarget(self, action: #selector(DemoCell.stateChangedOption2), for: UIControlEvents.valueChanged)
    
    super.awakeFromNib()
  }
  
  override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
    
    let durations = [0.26, 0.2, 0.2]
    return durations[itemIndex]
  }
    
  func stateChangedOption1(){
    if(option2.isOn){
        option2.setOn(false, animated: true)
    }
  }
    
  func stateChangedOption2(){
    if(option1.isOn){
        option1.setOn(false, animated: true)
    }
  }
    
}

extension DemoCell {
  
  @IBAction func buttonHandler(_ sender: AnyObject) {
    
    let alertController = YBAlertController(title: "Quantidade", message: "Quantas Galaxy Lover deseja?", style: .actionSheet)
    alertController.touchingOutsideDismiss = true
    alertController.buttonIconColor = UIColor(red: 255/255, green: 212/255, blue: 0/255, alpha: 1.0)
    alertController.cancelButtonTitle = "Cancelar"
    for i in 1 ..< 11 {
        if(i == 1){
            alertController.addButton(UIImage(named: "hop"), title: "\(i) cerveja", action: {
                
                SCLAlertView().showTitle(
                    "Cheers!",
                    subTitle: "\(i) cerveja \nSeu pedido já foi enviado.\nDaqui a pouco seu cartão virtual irá ser chamado.",
                    duration: 0.0,
                    completeText: "Ok",
                    style: .success,
                    colorStyle: 0xFFD400,
                    colorTextButton: 0xFFFFFF
                )
                
            })
        }else{
            alertController.addButton(UIImage(named: "hop"), title: "\(i) cervejas", action: {
                
                SCLAlertView().showTitle(
                    "Cheers!",
                    subTitle: "\(i) cervejas \nSeu pedido já foi enviado.\nDaqui a pouco seu cartão virtual irá ser chamado.",
                    duration: 0.0,
                    completeText: "Ok",
                    style: .success,
                    colorStyle: 0xFFD400,
                    colorTextButton: 0xFFFFFF
                )
                
            })
        }
    }
    
    alertController.show()
  }
}
