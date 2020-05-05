//
//  NewSettingsViewController.swift
//  PhotoJournal
//
//  Created by Yuliia Engman on 5/1/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

enum ScrollingDirection: String {
    case horizontal
    case vertical
}

protocol SettingsDelegate: AnyObject {
    func didSelectColor(backgroundColor: UIColor)
    func didSelectDirection(direction: ScrollingDirection)
}

class NewSettingsViewController: UIViewController {
    
    @IBOutlet weak var horizontalButton: UIButton!
    @IBOutlet weak var verticalButton: UIButton!
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var tealButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    
    
    lazy var scrollingDirectionButtons: [UIButton] = [horizontalButton, verticalButton]
    
    lazy var colorButtons: [UIButton] = [redButton, tealButton, whiteButton, yellowButton, greenButton]
    
    var backgroundColor = UIColor(named: "systemGray5")
    var direction = ScrollingDirection.vertical
    
    var settingsDelegate: SettingsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func horizontalScrollButtonPressed(_ sender: UIButton) {
        direction = ScrollingDirection.horizontal
        settingsDelegate?.didSelectDirection(direction: direction)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func verticalScrollButtonPressed(_ sender: UIButton) {
        direction = ScrollingDirection.vertical
        settingsDelegate?.didSelectDirection(direction: direction)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func redcolorButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func tealcolorButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func whitecolorButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func yellowcolorButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func greencolorButtonPressed(_ sender: UIButton) {
    }
    
    
}
