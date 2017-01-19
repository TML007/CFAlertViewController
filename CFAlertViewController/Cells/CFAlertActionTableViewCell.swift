//
//  CFAlertActionTableViewCell.swift
//  CFAlertViewControllerDemo
//
//  Created by Shivam Bhalla on 1/19/17.
//  Copyright © 2017 Codigami Inc. All rights reserved.
//

import UIKit


@objc(CFAlertActionTableViewCellDelegate)
protocol CFAlertActionTableViewCellDelegate {
    func alertActionCell(_ cell: CFAlertActionTableViewCell, didClickAction action: CFAlertAction?);
}


@objc(CFAlertActionTableViewCell)
class CFAlertActionTableViewCell: UITableViewCell {
    
    // MARK: - Declarations
    public static func CF_DEFAULT_ACTION_COLOR() -> UIColor {
        return UIColor(red: CGFloat(41.0 / 255.0), green: CGFloat(198.0 / 255.0), blue: CGFloat(77.0 / 255.0), alpha: CGFloat(1.0))
    }
    public static func CF_CANCEL_ACTION_COLOR() -> UIColor   {
        return UIColor(red: CGFloat(103.0 / 255.0), green: CGFloat(104.0 / 255.0), blue: CGFloat(217.0 / 255.0), alpha: CGFloat(1.0))
    }
    public static func CF_DESTRUCTIVE_ACTION_COLOR() -> UIColor  {
        return UIColor(red: CGFloat(255.0 / 255.0), green: CGFloat(75.0 / 255.0), blue: CGFloat(75.0 / 255.0), alpha: CGFloat(1.0))
    }
    
    
    // MARK: - Variables
    // MARK: Public
    public static func identifier() -> String    {
        return String(describing: CFAlertActionTableViewCell.self)
    }
    public var delegate: CFAlertActionTableViewCellDelegate?
    public var actionButtonTopMargin: CGFloat = 0.0 {
        didSet {
            // Update Constraint
            actionButtonTopConstraint?.constant = actionButtonTopMargin - 8.0
            layoutIfNeeded()
        }
    }
    public var actionButtonBottomMargin: CGFloat = 0.0 {
        didSet {
            // Update Constraint
            actionButtonBottomConstraint?.constant = actionButtonBottomMargin - 8.0
            layoutIfNeeded()
        }
    }
    public var action: CFAlertAction? {
        didSet {
            
            if let action = self.action    {
                
                // Set Action Style
                var actionColor: UIColor? = action.color
                
                switch action.style {
                    
                case .Cancel:
                    if actionColor == nil {
                        actionColor = CFAlertActionTableViewCell.CF_CANCEL_ACTION_COLOR()
                    }
                    actionButton?.backgroundColor = UIColor.clear
                    actionButton?.setTitleColor(actionColor, for: .normal)
                    actionButton?.layer.borderColor = actionColor?.cgColor
                    actionButton?.layer.borderWidth = 1.0
                    
                case .Destructive:
                    if actionColor == nil {
                        actionColor = CFAlertActionTableViewCell.CF_DESTRUCTIVE_ACTION_COLOR()
                    }
                    actionButton?.backgroundColor = actionColor
                    actionButton?.setTitleColor(UIColor.white, for: .normal)
                    actionButton?.layer.borderColor = nil
                    actionButton?.layer.borderWidth = 0.0
                    
                default:
                    if actionColor == nil {
                        actionColor = CFAlertActionTableViewCell.CF_DEFAULT_ACTION_COLOR()
                    }
                    actionButton?.backgroundColor = actionColor
                    actionButton?.setTitleColor(UIColor.white, for: .normal)
                    actionButton?.layer.borderColor = nil
                    actionButton?.layer.borderWidth = 0.0
                }
                
                
                // Set Alignment
                switch action.alignment {
                    
                case .Right:
                    // Right Align
                    actionButtonLeadingConstraint?.priority = 749.0
                    actionButtonCenterXConstraint?.isActive = false
                    actionButtonTrailingConstraint?.priority = 751.0
                    // Set Content Edge Inset
                    actionButton?.contentEdgeInsets = UIEdgeInsetsMake(12.0, 20.0, 12.0, 20.0)
                    
                case .Left:
                    // Left Align
                    actionButtonLeadingConstraint?.priority = 751.0
                    actionButtonCenterXConstraint?.isActive = false
                    actionButtonTrailingConstraint?.priority = 749.0
                    // Set Content Edge Inset
                    actionButton?.contentEdgeInsets = UIEdgeInsetsMake(12.0, 20.0, 12.0, 20.0)
                    
                case .Center:
                    // Center Align
                    actionButtonLeadingConstraint?.priority = 750.0
                    actionButtonCenterXConstraint?.isActive = true
                    actionButtonTrailingConstraint?.priority = 750.0
                    // Set Content Edge Inset
                    actionButton?.contentEdgeInsets = UIEdgeInsetsMake(12.0, 20.0, 12.0, 20.0)
                    
                default:
                    // Justified Align
                    actionButtonLeadingConstraint?.priority = 751.0
                    actionButtonCenterXConstraint?.isActive = false
                    actionButtonTrailingConstraint?.priority = 751.0
                    // Set Content Edge Inset
                    actionButton?.contentEdgeInsets = UIEdgeInsetsMake(15.0, 20.0, 15.0, 20.0)
                }
                
                // Set Title
                actionButton?.setTitle(self.action?.title, for: .normal)
            }
            else    {
                // Set Blank Title
                actionButton?.setTitle(nil, for: .normal)
            }
        }
    }
    
    // MARK: Private
    @IBOutlet private var actionButton: CFPushButton?
    @IBOutlet private weak var actionButtonTopConstraint: NSLayoutConstraint?
    @IBOutlet private weak var actionButtonLeadingConstraint: NSLayoutConstraint?
    @IBOutlet private weak var actionButtonCenterXConstraint: NSLayoutConstraint?
    @IBOutlet private weak var actionButtonTrailingConstraint: NSLayoutConstraint?
    @IBOutlet private weak var actionButtonBottomConstraint: NSLayoutConstraint?
    
    
    // MARK: - Initialization Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        basicInitialisation()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        basicInitialisation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func basicInitialisation() {
        // Set Action Button Properties
        actionButton?.layer.cornerRadius = 6.0
        actionButton?.pushTransformScaleFactor = 0.9
    }
    
    
    // MARK: - Layout Methods
    override func layoutSubviews() {
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }
    
    
    // MARK: - Button Click Events
    @IBAction internal func actionButtonClicked(_ sender: Any) {
        if let delegate = delegate {
            delegate.alertActionCell(self, didClickAction: action)
        }
    }
    
}