//
//  ContentView.swift
//  UITextItemTagAttributeName-Interaction
//
//  Created by Leo Tumwattana on 24/6/2023.
//

import SwiftUI
import UIKit

/**
 Discussion:
 
 This sample project shows how text with .textItemTag attribute set is not triggering the new APIs:
 
 1. func textView(_ textView: UITextView, primaryActionFor textItem: UITextItem, defaultAction: UIAction) -> UIAction?
 2. func textView(_ textView: UITextView, menuConfigurationFor textItem: UITextItem, defaultMenu: UIMenu) -> UITextItem.MenuConfiguration?
 */

/**
 Attributed string
 */
let attributedString: NSAttributedString = {
    let mutableAttributedString = NSMutableAttributedString()
    mutableAttributedString.append(NSAttributedString(string: "This is some normal text\n\n"))
    mutableAttributedString.append(NSAttributedString(string: "This is a link and it's tappable to show UITextItem menu\n\n", attributes: [
        .link: URL(string: "https://www.apple.com")!
    ]))
    mutableAttributedString.append(NSAttributedString(string: "Here are some text with UITextItemTag applied. This doesn't seem to show menu.", attributes: [
        .textItemTag: true,
        .foregroundColor: UIColor.systemPurple
    ]))
    mutableAttributedString.addAttributes([
        .font: UIFont.preferredFont(forTextStyle: .body)
    ], range: NSRange(location: 0, length: mutableAttributedString.length))
    return mutableAttributedString
}()

/**
 ContentView with UITextView
 */
struct ContentView: View {
    var body: some View {
        VStack {
            TextView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

/**
 UIViewRepresentable of UITextView
 */
struct TextView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.attributedText = attributedString
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    typealias UIViewType = UITextView
    
    final class Coordinator: NSObject, UITextViewDelegate {
        
        let parent: TextView
        
        init(parent: TextView) {
            self.parent = parent
        }
        
        /**
         UITextViewDelegate
         */
        
        // Don't have primary action and instead show menu
        func textView(_ textView: UITextView, primaryActionFor textItem: UITextItem, defaultAction: UIAction) -> UIAction? {
            nil
        }
        
        // Try to show a sample menu for any type of UITextItem.
        func textView(_ textView: UITextView, menuConfigurationFor textItem: UITextItem, defaultMenu: UIMenu) -> UITextItem.MenuConfiguration? {
            let menu = UIMenu(title: "Custom menu", children: [
                UIAction(title: "Some action", handler: { _ in })
            ])
            return UITextItem.MenuConfiguration(menu: menu)
        }
    }
    
}
