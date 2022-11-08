## スクロール最下部検知

<img width="636" alt="スクリーンショット 2022-11-09 0 50 12" src="https://user-images.githubusercontent.com/16571394/200611744-d7d8eaf0-5654-475a-adf4-4532dd1bc30c.png">

scrollViewに乗った最後のViewのmaxYがある高さよりも小さい場合というロジックの組み方

```
extension View {
    func readFrame(_ readFrame: @escaping (CGRect) -> ()) -> some View {
        background(
            GeometryReader { proxy -> AnyView in
                readFrame(proxy.frame(in: .global))
                return AnyView(EmptyView())
            }
        )
    }
}

                    VStack(spacing: 0) {
                        ForEach(historyList.histories, id: \.id) { history in
                            if let lastId = historyList.histories.last?.id,
                               lastId == history.id {
                                
                                DoorHistoryListCell(viewData: history)
                                    .readFrame { cgrect in
                                        // 
                                        if cgrect.maxY <= UIScreen.main.bounds.height {
                                            
                                            print("@@@ 通過 =\(history.historyId)")
                                            
                                            if !viewModel.isRequesting, viewModel.lastHistoryIds.contains(history.historyId) == false {
//                                                viewModel.getNextHistories()
                                                DispatchQueue.main.async {
                                                    self.viewModel.getMoreHistoryTest(historyId: history.historyId)
                                                }
                                            }
                                        }
                                    }
                             
                            } else {
                                DoorHistoryListCell(viewData: history)
                                
                                Divider(color: Color.akOutline)
                                    .padding(.leading, 16.0)
                            }
                        }
                    }
```
