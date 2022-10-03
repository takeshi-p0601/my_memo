## asyncメソッドのテスト

下記のようなasyncメソッドがあったとする

```
ViewModel {
  var isRequested = false

  func fetchTest() async {
    let result = await apiClient.fetch()
    self.isRequested = true
  }

}

```

テストコードは下記のようにかける

```

func testRaceCondition() async {
   let stubApiClient = StubApiClient(dummyResult: nil)
   let viewModel = ViewModel(apiClient: stubApiClient)
 
   await viewModel.fetchTest()
   XCTAssertEqual(true, viewModel.isRequested)
}

```

## 内部にTaskがある場合のテスト

下記のようなTask内部にasyncメソッドがあったとする

```
ViewModel {
 var isRequested = false

func fetchTest() {
  Task {
     let result = await apiClient.fetch()
     self.isRequested = true
   }
 }
}

```

テストコードは下記のようにかける

```
    func testAsynchronousFunction() {
        let functionAnswered = expectation(description: "asynchronous function")
        asynchronousFunction { (viewModel) in
            XCTAssertEqual(viewModel.isRequested, true)
            functionAnswered.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func asynchronousFunction(_ completionHandler: @escaping (ViewModel) -> Void) {
        let queue = DispatchQueue.global()
        queue.async {
            let stubApiClient = StubApiClient(dummyResult: nil)
            let viewModel = ViewModel(apiClient: stubApiClient)
            viewModel.fetchTest()
            Thread.sleep(forTimeInterval: 1)
            completionHandler(viewModel)
        }
    }
```

下記みたいなものもできた

```
DispatchQueue.main.async {
   let stubICCardInput = StubICCardManager(dummyScanResult: .fail(.failScan))
   let viewModel2 = ICCardScanViewModel(iccardInput: stubICCardInput, isSelectedOtherCardType: true)
   viewModel2.scanICCard(alertMessage: "dummy")
   Thread.sleep(forTimeInterval: 1)
   XCTAssertEqual(viewModel2.scanFailed, true)
}
```
