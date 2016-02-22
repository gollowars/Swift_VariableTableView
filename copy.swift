//
//  ViewController.swift
//  St_VariableTable
//
//  Created by Yoshizumi Ashikawa on 2016/02/22.
//  Copyright © 2016年 Yoshizumi Ashikawa. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GetTextDelegate {
  var tbv: UITableView!
  var viewModel = ViewModel()
  var items = [String]()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nil, bundle: nil)
    viewModel.delegate = self
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    let barHeight = UIApplication.sharedApplication().statusBarFrame.size.height

    tbv = UITableView(frame: CGRectMake(0, barHeight, view.frame.width, view.frame.height-barHeight))
    tbv.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
    tbv.dataSource = self
    tbv.delegate = self
    view.addSubview(tbv)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)


    cell.textLabel?.text = items[indexPath.row]
    cell.textLabel?.layer.frame = CGRectMake(0, 0, 100, 200)
    return cell
  }

  func pushText(text:String){
    items.append(text)
    tbv.reloadData()
  }


  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

  func calcHeight(str:String)->CGRect{
    let text = str
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
    let attributeDict = [
      NSFontAttributeName: UIFont.systemFontOfSize(16.0),
      NSParagraphStyleAttributeName: paragraphStyle
    ]
    let constraintsSize = CGSizeMake(100, 100)
    let textSize = NSString(string: text).boundingRectWithSize(constraintsSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributeDict, context: nil)
    return textSize
  }
  
}