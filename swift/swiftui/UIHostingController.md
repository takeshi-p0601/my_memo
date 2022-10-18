## SwiftUIのViewを載せたUIHostingVCに、overcurrentContextを設定する方法

baseVCの上に、HosingControlerを置いて、baseVCにoverCurrentContextを適用させ、baseVCをpresentさせる
```
        let baseVC = UIViewController()
        baseVC.view.backgroundColor = .black.withAlpha(0.5)
        baseVC.modalPresentationStyle = .overCurrentContext

        let indicator = AlertIndicator(title: "title", description: "desc", shouldShowCancelButton: false, vm: alertIndicatorViewModel)
        let hostVC = UIHostingController(rootView: indicator)
        hostVC.view.frame = baseVC.view.frame
        hostVC.view.backgroundColor = .clear
        baseVC.view.addSubview(hostVC.view)

        present(baseVC, animated: false)
```
