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
    cell.textLabel?.numberOfLines = 0
		cell.textLabel?.layer.frame = CGRectMake(0, 0, 100, 200)
    return cell
  }

  func pushText(text:String){
    items.append(text)
    tbv.reloadData()
  }

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let text = items[indexPath.row]
    let h = heightWithText(text)
    return h
  }

  func heightWithText(text: String) -> CGFloat {

    let horizonMergin:CGFloat = 32
    let verticalMergin:CGFloat = 32

    let maxSize = CGSize(width: CGRectGetWidth(UIScreen.mainScreen().bounds) - horizonMergin, height: CGFloat.max)
    let options = unsafeBitCast(
      NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
        NSStringDrawingOptions.UsesFontLeading.rawValue,
      NSStringDrawingOptions.self)

    // ここは必要に応じて
    let paragrahStyle = NSMutableParagraphStyle()
    paragrahStyle.lineHeightMultiple = 1.3
    paragrahStyle.lineSpacing = 4

    let font = UIFont.systemFontOfSize(14.0)
    let attributes = [NSFontAttributeName:font,
      NSParagraphStyleAttributeName:paragrahStyle]

    let frame = text.boundingRectWithSize(maxSize,
      options: options,
      attributes: attributes,
      context: nil)
    let height = ceil(frame.size.height) + verticalMergin

    return height
  }
}