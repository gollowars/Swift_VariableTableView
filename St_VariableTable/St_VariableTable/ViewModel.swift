//
//  ViewModel.swift
//  St_VariableTable
//
//  Created by Yoshizumi Ashikawa on 2016/02/22.
//  Copyright © 2016年 Yoshizumi Ashikawa. All rights reserved.
//

import Foundation

protocol GetTextDelegate {
  func pushText(text:String)
}

class ViewModel {
  var delegate: GetTextDelegate?
  var timer:NSTimeInterval!
  init(){
		setIntervalPushText()
  }

  func setIntervalPushText(){
    NSTimer.schedule(repeatInterval: 5.0){ timer in
      self.delegate?.pushText(self.randomText())
    }
  }

  internal func randomText()->String{
  	let length = UInt32(DummyText.text.characters.count)
    let random = Int(floor(Double(arc4random() % length)))
		let str = NSString(string: DummyText.text)
    let substr = str.substringToIndex(random)

    print(substr)
    return String(substr)
  }
}