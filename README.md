# UITextItemTagAttributeName-Issue

## Issue:
NSAttributedString with attribute `.textItemTag` set does not trigger the new UITextViewDelegates:

```
1. func textView(_ textView: UITextView, primaryActionFor textItem: UITextItem, defaultAction: UIAction) -> UIAction?
2. func textView(_ textView: UITextView, menuConfigurationFor textItem: UITextItem, defaultMenu: UIMenu) -> UITextItem.MenuConfiguration?
```

Seems like only `.link` will trigger them.
