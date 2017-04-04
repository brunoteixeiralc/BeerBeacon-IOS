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
  
  var number: Int = 0 {
    didSet {
      closeNumberLabel.text = String(number)
      openNumberLabel.text = "Tap \(String(number))"
    }
  }
  override func awakeFromNib() {
    
    foregroundView.layer.cornerRadius = 10
    foregroundView.layer.masksToBounds = true
    
    super.awakeFromNib()
  }
  
  override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
    
    let durations = [0.26, 0.2, 0.2]
    return durations[itemIndex]
  }
}

// MARK: Actions
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
