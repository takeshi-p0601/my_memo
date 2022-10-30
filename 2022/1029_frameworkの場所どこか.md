## frameworkの場所はどこか

アプリを作成して、実行バイナリにリンクされているライブラリを確認してみる

```
$ otool -L ~/Library/Developer/Xcode/DerivedData/testNavi-ewiibuofioktglftgafsywfetynw/Build/Products/Debug-iphonesimulator/testNavi.app/testNavi 
/Users/takeshikomori/Library/Developer/Xcode/DerivedData/testNavi-ewiibuofioktglftgafsywfetynw/Build/Products/Debug-iphonesimulator/testNavi.app/testNavi:
	/System/Library/Frameworks/Foundation.framework/Foundation (compatibility version 300.0.0, current version 1946.102.0)
	/usr/lib/libobjc.A.dylib (compatibility version 1.0.0, current version 228.0.0)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1319.0.0)
	/System/Library/Frameworks/UIKit.framework/UIKit (compatibility version 1.0.0, current version 6092.1.111)
	/usr/lib/swift/libswiftCore.dylib (compatibility version 1.0.0, current version 5.7.0)
	/usr/lib/swift/libswiftCoreFoundation.dylib (compatibility version 1.0.0, current version 120.100.0, weak)
	/usr/lib/swift/libswiftCoreGraphics.dylib (compatibility version 1.0.0, current version 15.0.0, weak)
	/usr/lib/swift/libswiftCoreImage.dylib (compatibility version 1.0.0, current version 2.0.0, weak)
	/usr/lib/swift/libswiftDarwin.dylib (compatibility version 1.0.0, current version 0.0.0, weak)
	/usr/lib/swift/libswiftDataDetection.dylib (compatibility version 1.0.0, current version 723.0.0, weak)
	/usr/lib/swift/libswiftDispatch.dylib (compatibility version 1.0.0, current version 17.0.0, weak)
	/usr/lib/swift/libswiftFileProvider.dylib (compatibility version 1.0.0, current version 730.0.125, weak)
	/usr/lib/swift/libswiftMetal.dylib (compatibility version 1.0.0, current version 306.1.19, weak)
	/usr/lib/swift/libswiftObjectiveC.dylib (compatibility version 1.0.0, current version 6.0.0)
	/usr/lib/swift/libswiftQuartzCore.dylib (compatibility version 1.0.0, current version 3.0.0, weak)
	/usr/lib/swift/libswiftUIKit.dylib (compatibility version 1.0.0, current version 6092.1.111)
	/usr/lib/swift/libswiftFoundation.dylib (compatibility version 1.0.0, current version 1.0.0)
```

`/System/Library/Frameworks/UIKit.framework/UIKit (compatibility version 1.0.0, current version 6092.1.111)` はどこにあるんだろうか

Xcode14.0.1の環境で下記

Xcode14.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/UIKit.framework/UIKit

`Xcode14.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profile/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot` 

上記が省略されている?

参考: https://stackoverflow.com/questions/24544916/cannot-find-uikit-framework

ちなみに、動的ライブラリである

```
$ file /Applications/Xcode14.0.1.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/UIKit.framework/UIKit 
/Applications/Xcode14.0.1.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/UIKit.framework/UIKit: Mach-O universal binary with 2 architectures: [x86_64:Mach-O 64-bit dynamically linked shared library x86_64
- Mach-O 64-bit dynamically linked shared library x86_64] [arm64:Mach-O 64-bit dynamically linked shared library arm64
- Mach-O 64-bit dynamically linked shared library arm64]
/Applications/Xcode14.0.1.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/UIKit.framework/UIKit (for architecture x86_64):	Mach-O 64-bit dynamically linked shared library x86_64
/Applications/Xcode14.0.1.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks/UIKit.framework/UIKit (for architecture arm64):	Mach-O 64-bit dynamically linked shared library arm64
```

moduleの位置はここ?

`/Applications/Xcode14.0.1.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS15.5.sdk/System/Library/Frameworks/UIKit.framework`

```
[takeshikomori@MacBook-Pro-2:/Applications/Xcode14.0.1.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/UIKit.framework]
$ tree
.
├── Headers
│   ├── DocumentManager.h
│   ├── NSAttributedString.h
│   ├── NSDataAsset.h
│   ├── NSDiffableDataSourceSectionSnapshot.h
│   ├── NSFileProviderExtension.h
│   ├── NSIndexPath+UIKitAdditions.h
│   ├── NSItemProvider+UIKitAdditions.h
│   ├── NSLayoutAnchor.h
│   ├── NSLayoutConstraint.h
│   ├── NSLayoutManager.h
│   ├── NSParagraphStyle.h
│   ├── NSShadow.h
│   ├── NSStringDrawing.h
│   ├── NSText.h
│   ├── NSTextAttachment.h
│   ├── NSTextContainer.h
│   ├── NSTextContentManager.h
│   ├── NSTextElement.h
│   ├── NSTextLayoutFragment.h
│   ├── NSTextLayoutManager.h
│   ├── NSTextLineFragment.h
│   ├── NSTextList.h
│   ├── NSTextListElement.h
│   ├── NSTextRange.h
│   ├── NSTextSelection.h
│   ├── NSTextSelectionNavigation.h
│   ├── NSTextStorage.h
│   ├── NSTextViewportLayoutController.h
│   ├── NSToolbar+UIKitAdditions.h
│   ├── NSTouchBar+UIKitAdditions.h
│   ├── NSUserActivity+NSItemProvider.h
│   ├── PrintKitUI.h
│   ├── ShareSheet.h
│   ├── UIAccelerometer.h
│   ├── UIAccessibility.h
│   ├── UIAccessibilityAdditions.h
│   ├── UIAccessibilityConstants.h
│   ├── UIAccessibilityContainer.h
│   ├── UIAccessibilityContentSizeCategoryImageAdjusting.h
│   ├── UIAccessibilityCustomAction.h
│   ├── UIAccessibilityCustomRotor.h
│   ├── UIAccessibilityElement.h
│   ├── UIAccessibilityIdentification.h
│   ├── UIAccessibilityLocationDescriptor.h
│   ├── UIAccessibilityZoom.h
│   ├── UIAction.h
│   ├── UIActionSheet.h
│   ├── UIActivity.h
│   ├── UIActivityIndicatorView.h
│   ├── UIActivityItemProvider.h
│   ├── UIActivityItemsConfiguration.h
│   ├── UIActivityItemsConfigurationReading.h
│   ├── UIActivityViewController.h
│   ├── UIAlert.h
│   ├── UIAlertController.h
│   ├── UIAlertView.h
│   ├── UIAppearance.h
│   ├── UIApplication.h
│   ├── UIApplicationShortcutItem.h
│   ├── UIAttachmentBehavior.h
│   ├── UIBackgroundConfiguration.h
│   ├── UIBandSelectionInteraction.h
│   ├── UIBarAppearance.h
│   ├── UIBarButtonItem.h
│   ├── UIBarButtonItemAppearance.h
│   ├── UIBarButtonItemGroup.h
│   ├── UIBarCommon.h
│   ├── UIBarItem.h
│   ├── UIBehavioralStyle.h
│   ├── UIBezierPath.h
│   ├── UIBlurEffect.h
│   ├── UIButton.h
│   ├── UIButtonConfiguration.h
│   ├── UICalendarSelection.h
│   ├── UICalendarSelectionMultiDate.h
│   ├── UICalendarSelectionSingleDate.h
│   ├── UICalendarView.h
│   ├── UICalendarViewDecoration.h
│   ├── UICellAccessory.h
│   ├── UICellConfigurationState.h
│   ├── UICloudSharingController.h
│   ├── UICollectionLayoutList.h
│   ├── UICollectionView.h
│   ├── UICollectionViewCell.h
│   ├── UICollectionViewCompositionalLayout.h
│   ├── UICollectionViewController.h
│   ├── UICollectionViewFlowLayout.h
│   ├── UICollectionViewItemRegistration.h
│   ├── UICollectionViewLayout.h
│   ├── UICollectionViewListCell.h
│   ├── UICollectionViewTransitionLayout.h
│   ├── UICollectionViewUpdateItem.h
│   ├── UICollisionBehavior.h
│   ├── UIColor.h
│   ├── UIColorPickerViewController.h
│   ├── UIColorWell.h
│   ├── UICommand.h
│   ├── UIConfigurationColorTransformer.h
│   ├── UIConfigurationState.h
│   ├── UIContentConfiguration.h
│   ├── UIContentSizeCategory.h
│   ├── UIContentSizeCategoryAdjusting.h
│   ├── UIContextMenuConfiguration.h
│   ├── UIContextMenuInteraction.h
│   ├── UIContextualAction.h
│   ├── UIControl.h
│   ├── UIDataDetectors.h
│   ├── UIDataSourceTranslating.h
│   ├── UIDatePicker.h
│   ├── UIDeferredMenuElement.h
│   ├── UIDevice.h
│   ├── UIDiffableDataSource.h
│   ├── UIDocument.h
│   ├── UIDocumentBrowserAction.h
│   ├── UIDocumentBrowserViewController.h
│   ├── UIDocumentInteractionController.h
│   ├── UIDocumentMenuViewController.h
│   ├── UIDocumentPickerExtensionViewController.h
│   ├── UIDocumentPickerViewController.h
│   ├── UIDocumentProperties.h
│   ├── UIDragInteraction.h
│   ├── UIDragItem.h
│   ├── UIDragPreview.h
│   ├── UIDragPreviewParameters.h
│   ├── UIDragSession.h
│   ├── UIDropInteraction.h
│   ├── UIDynamicAnimator.h
│   ├── UIDynamicBehavior.h
│   ├── UIDynamicItemBehavior.h
│   ├── UIEditMenuInteraction.h
│   ├── UIEvent.h
│   ├── UIEventAttribution.h
│   ├── UIEventAttributionView.h
│   ├── UIFeedbackGenerator.h
│   ├── UIFieldBehavior.h
│   ├── UIFindInteraction.h
│   ├── UIFindSession.h
│   ├── UIFocus.h
│   ├── UIFocusAnimationCoordinator.h
│   ├── UIFocusDebugger.h
│   ├── UIFocusEffect.h
│   ├── UIFocusGuide.h
│   ├── UIFocusMovementHint.h
│   ├── UIFocusSystem.h
│   ├── UIFont.h
│   ├── UIFontDescriptor.h
│   ├── UIFontMetrics.h
│   ├── UIFontPickerViewController.h
│   ├── UIFontPickerViewControllerConfiguration.h
│   ├── UIFoundation.h
│   ├── UIGeometry.h
│   ├── UIGestureRecognizer.h
│   ├── UIGestureRecognizerSubclass.h
│   ├── UIGraphics.h
│   ├── UIGraphicsImageRenderer.h
│   ├── UIGraphicsPDFRenderer.h
│   ├── UIGraphicsRenderer.h
│   ├── UIGraphicsRendererSubclass.h
│   ├── UIGravityBehavior.h
│   ├── UIGuidedAccess.h
│   ├── UIGuidedAccessRestrictions.h
│   ├── UIHoverGestureRecognizer.h
│   ├── UIImage.h
│   ├── UIImageAsset.h
│   ├── UIImageConfiguration.h
│   ├── UIImagePickerController.h
│   ├── UIImageSymbolConfiguration.h
│   ├── UIImageView.h
│   ├── UIImpactFeedbackGenerator.h
│   ├── UIIndirectScribbleInteraction.h
│   ├── UIInputView.h
│   ├── UIInputViewController.h
│   ├── UIInteraction.h
│   ├── UIInterface.h
│   ├── UIKey.h
│   ├── UIKeyCommand.h
│   ├── UIKeyConstants.h
│   ├── UIKeyboardLayoutGuide.h
│   ├── UIKit.apinotes
│   ├── UIKit.h
│   ├── UIKitCore.h
│   ├── UIKitDefines.h
│   ├── UILabel.h
│   ├── UILargeContentViewer.h
│   ├── UILayoutGuide.h
│   ├── UILexicon.h
│   ├── UIListContentConfiguration.h
│   ├── UIListContentImageProperties.h
│   ├── UIListContentTextProperties.h
│   ├── UIListSeparatorConfiguration.h
│   ├── UILocalNotification.h
│   ├── UILocalizedIndexedCollation.h
│   ├── UILongPressGestureRecognizer.h
│   ├── UIManagedDocument.h
│   ├── UIMenu.h
│   ├── UIMenuBuilder.h
│   ├── UIMenuController.h
│   ├── UIMenuElement.h
│   ├── UIMenuLeaf.h
│   ├── UIMenuSystem.h
│   ├── UIMotionEffect.h
│   ├── UINavigationBar.h
│   ├── UINavigationBarAppearance.h
│   ├── UINavigationController.h
│   ├── UINavigationItem.h
│   ├── UINib.h
│   ├── UINibDeclarations.h
│   ├── UINibLoading.h
│   ├── UINotificationFeedbackGenerator.h
│   ├── UIOpenURLContext.h
│   ├── UIPageControl.h
│   ├── UIPageViewController.h
│   ├── UIPanGestureRecognizer.h
│   ├── UIPasteConfiguration.h
│   ├── UIPasteConfigurationSupporting.h
│   ├── UIPasteControl.h
│   ├── UIPasteboard.h
│   ├── UIPencilInteraction.h
│   ├── UIPickerView.h
│   ├── UIPinchGestureRecognizer.h
│   ├── UIPointerAccessory.h
│   ├── UIPointerInteraction.h
│   ├── UIPointerLockState.h
│   ├── UIPointerRegion.h
│   ├── UIPointerStyle.h
│   ├── UIPopoverBackgroundView.h
│   ├── UIPopoverController.h
│   ├── UIPopoverPresentationController.h
│   ├── UIPopoverPresentationControllerSourceItem.h
│   ├── UIPopoverSupport.h
│   ├── UIPresentationController.h
│   ├── UIPress.h
│   ├── UIPressesEvent.h
│   ├── UIPreviewInteraction.h
│   ├── UIPreviewParameters.h
│   ├── UIPrintError.h
│   ├── UIPrintFormatter.h
│   ├── UIPrintInfo.h
│   ├── UIPrintInteractionController.h
│   ├── UIPrintPageRenderer.h
│   ├── UIPrintPaper.h
│   ├── UIPrintServiceExtension.h
│   ├── UIPrinter.h
│   ├── UIPrinterPickerController.h
│   ├── UIProgressView.h
│   ├── UIPushBehavior.h
│   ├── UIReferenceLibraryViewController.h
│   ├── UIRefreshControl.h
│   ├── UIRegion.h
│   ├── UIResponder+UIActivityItemsConfiguration.h
│   ├── UIResponder.h
│   ├── UIRotationGestureRecognizer.h
│   ├── UIScene.h
│   ├── UISceneActivationConditions.h
│   ├── UISceneDefinitions.h
│   ├── UISceneEnhancedStateRestoration.h
│   ├── UISceneOptions.h
│   ├── UISceneSession.h
│   ├── UISceneWindowingBehaviors.h
│   ├── UIScreen.h
│   ├── UIScreenEdgePanGestureRecognizer.h
│   ├── UIScreenMode.h
│   ├── UIScreenshotService.h
│   ├── UIScribbleInteraction.h
│   ├── UIScrollView.h
│   ├── UISearchBar.h
│   ├── UISearchContainerViewController.h
│   ├── UISearchController.h
│   ├── UISearchDisplayController.h
│   ├── UISearchSuggestion.h
│   ├── UISearchTextField.h
│   ├── UISegmentedControl.h
│   ├── UISelectionFeedbackGenerator.h
│   ├── UISheetPresentationController.h
│   ├── UISlider.h
│   ├── UISnapBehavior.h
│   ├── UISplitViewController.h
│   ├── UISpringLoadedInteraction.h
│   ├── UISpringLoadedInteractionSupporting.h
│   ├── UIStackView.h
│   ├── UIStateRestoration.h
│   ├── UIStatusBarManager.h
│   ├── UIStepper.h
│   ├── UIStoryboard.h
│   ├── UIStoryboardPopoverSegue.h
│   ├── UIStoryboardSegue.h
│   ├── UIStringDrawing.h
│   ├── UISwipeActionsConfiguration.h
│   ├── UISwipeGestureRecognizer.h
│   ├── UISwitch.h
│   ├── UITabBar.h
│   ├── UITabBarAppearance.h
│   ├── UITabBarController.h
│   ├── UITabBarItem.h
│   ├── UITableView.h
│   ├── UITableViewCell.h
│   ├── UITableViewController.h
│   ├── UITableViewHeaderFooterView.h
│   ├── UITapGestureRecognizer.h
│   ├── UITargetedDragPreview.h
│   ├── UITargetedPreview.h
│   ├── UITextChecker.h
│   ├── UITextDragPreviewRenderer.h
│   ├── UITextDragURLPreviews.h
│   ├── UITextDragging.h
│   ├── UITextDropProposal.h
│   ├── UITextDropping.h
│   ├── UITextField.h
│   ├── UITextFormattingCoordinator.h
│   ├── UITextInput.h
│   ├── UITextInputTraits.h
│   ├── UITextInteraction.h
│   ├── UITextItemInteraction.h
│   ├── UITextPasteConfigurationSupporting.h
│   ├── UITextPasteDelegate.h
│   ├── UITextSearching.h
│   ├── UITextView.h
│   ├── UITimingCurveProvider.h
│   ├── UITimingParameters.h
│   ├── UIToolTipInteraction.h
│   ├── UIToolbar.h
│   ├── UIToolbarAppearance.h
│   ├── UITouch.h
│   ├── UITrackingLayoutGuide.h
│   ├── UITraitCollection.h
│   ├── UIUserActivity.h
│   ├── UIUserNotificationSettings.h
│   ├── UIVibrancyEffect.h
│   ├── UIVideoEditorController.h
│   ├── UIView.h
│   ├── UIViewAnimating.h
│   ├── UIViewConfigurationState.h
│   ├── UIViewController.h
│   ├── UIViewControllerTransitionCoordinator.h
│   ├── UIViewControllerTransitioning.h
│   ├── UIViewPropertyAnimator.h
│   ├── UIVisualEffect.h
│   ├── UIVisualEffectView.h
│   ├── UIWebView.h
│   ├── UIWindow.h
│   ├── UIWindowScene.h
│   ├── UIWindowSceneActivationAction.h
│   ├── UIWindowSceneActivationConfiguration.h
│   ├── UIWindowSceneActivationInteraction.h
│   ├── UIWindowSceneActivationRequestOptions.h
│   ├── UIWindowSceneGeometry.h
│   ├── UIWindowSceneGeometryPreferences.h
│   ├── UIWindowSceneGeometryPreferencesIOS.h
│   ├── UIWindowSceneGeometryPreferencesMac.h
│   └── UNNotificationResponse+UIKitAdditions.h
├── Modules
│   └── module.modulemap
└── UIKit.tbd

2 directories, 352 files
```

下記も時間がるとき見てみる

https://qiita.com/usagimaru/items/82cf2a1fb8399c5a1be1

