//
//  Label.swift
//  Few
//
//  Created by Josh Abernathy on 8/5/14.
//  Copyright (c) 2014 Josh Abernathy. All rights reserved.
//

import Foundation
import AppKit

public class Label<S: Equatable>: Element<S> {
	private var textField: NSTextField?

	private var text: String

	public init(text: String) {
		self.text = text
	}

	// MARK: Element

	public override func applyDiff(other: Element<S>) {
		if textField == nil { return }

		let otherLabel = other as Label
		if text != otherLabel.text {
			text = otherLabel.text
			textField!.stringValue = text
		}

		frame = CGRectZero

		super.applyDiff(other)
	}

	public override func realize(component: Component<S>, parentView: NSView) {
		let field = NSTextField(frame: frame)
		field.editable = false
		field.drawsBackground = false
		field.bordered = false
		field.stringValue = text
		textField = field

		super.realize(component, parentView: parentView)
	}

	public override func getContentView() -> NSView? {
		return textField
	}
	
	public override func getIntrinsicSize() -> CGSize {
		var size = CGSizeZero
		if let textField = textField {
			let originalFrame = textField.frame
			textField.sizeToFit()
			size = textField.bounds.size
			textField.frame = originalFrame
		}
		return size
	}
}