//
//  TokenTextView.swift
//  Hosty
//
//  Created by Ahmed Shaaban on 6/7/20.
//  Copyright © 2020 Shaabs. All rights reserved.
// Many thanks for this OBJ C implemetation which informed my own:  https://aimannajjarblog.wordpress.com/2015/09/26/how-to-create-nstextview-with-facebook-like-tagsmentions/
//

import Foundation
import AppKit

extension NSAttributedString.Key {
    static let tag = NSAttributedString.Key(rawValue: "tag")
}

struct TagAttributes {
    var fillColor: NSColor
    var textColor: NSColor
    var strokeColor: NSColor
}

class TokenTextView: NSTextField {
    override func insertNewline(_ sender: Any?) {
        // consume and discard
    }

    override func insertNewlineIgnoringFieldEditor(_ sender: Any?) {
        // consume and discard
    }

   
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//        let attributedString = self.attributedStringValue;
//        attributedString.enumerateAttributes(in: NSRange(location: 0, length: attributedString.string.count), options: NSAttributedString.EnumerationOptions.reverse) { (attributes: [NSAttributedString.Key : Any], range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) in
//            if let tagAttribute  = attributes[NSAttributedString.Key.tag] as! TagAttributes? {
//                
//                var textStorage = NSTextStorage(attributedString: attributedString)
//                var textContainer = NSTextContainer(containerSize: NSSize(width: self.frame.size.width, height: .greatestFiniteMagnitude))
//                var layoutManager = NSLayoutManager();
//                
//                layoutManager.addTextContainer(textContainer);
//                textStorage.addLayoutManager(layoutManager);
//                textContainer.lineFragmentPadding = 2;
//                
//                var tagRect = layoutManager.boundingRect(forGlyphRange: range, in: textContainer)
//                
//                tagRect.origin.y += 3;
//                tagRect.origin.x += 2;
//                tagRect.size.height += 1;
//                
//                var tagAttrs = attributedString.attributes(at: range.location, effectiveRange: nil)
//                var oneCharSize = NSString(string: "a").size(withAttributes: tagAttrs)
//                var tagBorderRect = NSRect(x: tagRect.origin.x-oneCharSize.width*0.25, y: tagRect.origin.y+1, width: tagRect.size.width+oneCharSize.width*0.33, height: tagRect.size.height)
//                
//                NSGraphicsContext.saveGraphicsState();
//                
//                var path = NSBezierPath(roundedRect: tagBorderRect, xRadius: 3.0, yRadius: 3.0)
//                
//                var fillColor = NSColor(cgColor: tagAttribute.fillColor.cgColor)!;
//                var textColor = NSColor(cgColor: tagAttribute.textColor.cgColor)!;
//                var strokeColor = NSColor(cgColor: tagAttribute.strokeColor.cgColor)!;
//                
//                path.addClip();
//
//                fillColor.setFill();
//                strokeColor.setStroke();
//                tagBorderRect.fill(using: NSCompositingOperation.sourceOver)
//                
//                var transform = AffineTransform()
//                transform.translate(x: 0.5, y: 0.5)
//                path.transform(using: transform);
//                
//                path.stroke();
//                
//                transform.translate(x: -1.5, y: -1.5)
//                path.transform(using: transform)
//                
//                path.stroke()
//                
//                let newDict = NSMutableDictionary(dictionary: tagAttrs);
//                
//                var font = (tagAttrs[NSAttributedString.Key.font] as! NSFont).copy() as! NSFont;
//                font = NSFontManager.shared.convert(font, toSize: font.pointSize - 0.25);
//                newDict.addEntries(from: [
//                    NSAttributedString.Key.font: font,
//                    NSAttributedString.Key.foregroundColor: textColor
//                ])
//                let drawString = NSString(string: NSString(string: attributedString.string).substring(with: range));
//                drawString.draw(in: tagRect, withAttributes: newDict as! [NSAttributedString.Key : Any])
//                
//                NSGraphicsContext.restoreGraphicsState()
//            }
//        }
//    }
}
