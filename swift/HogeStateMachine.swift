import Foundation
import Combine

enum HogeDoorViewState: Equatable {
    case None
    case Loading
    case UnLocked
    case Locked
    case Retryable
}

class HogeViewModel: ObservableObject {
    private let stateMachine: HogeStateMachine
    
    @Published var remoteFlg: Bool = false
    @Published var doorState: HogeDoorViewState = .None
    
//    @Published var isLoading: Bool = false
//    @Published var failedData: (Bool, String?) = (isFailed: false, error: nil)
//    @Published var isLocked: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(stateMachine: HogeStateMachine) {
        self.stateMachine = stateMachine
        
        $remoteFlg
            .sink {
                stateMachine.action.send(.changeRemoteFlg($0))
            }
            .store(in: &cancellables)
        
        bindStateMachine()
    }
    
    private func bindStateMachine() {
        stateMachine.state
            .sink { state in
                switch state {
                case .None:
                    self.doorState = .None
                    
                case .LoadingFetchState, .LoadingUnLock, .LoadingLock:
                    self.doorState = .Loading
                    
                case .SuccessFetchState(let isLocked):
                    self.doorState = isLocked ? .Locked : .UnLocked
                    
                case .FailFetchState:
                    self.doorState = .Retryable
                    
                case .SuccessUnLock:
                    self.doorState = .None
                    
                case .FailUnLock:
                    self.doorState = .Retryable
                    
                case .SuccessLock:
                    self.doorState = .None
                    
                case .FailLock:
                    self.doorState = .Retryable
                    
                }
            }
            .store(in: &cancellables)
    }
    
    func tryOpen() {
        stateMachine.action.send(.tryUnLock)
    }
    
    func tryClose() {
        stateMachine.action.send(.tryLock)
    }
    
    func retry() {
        stateMachine.action.send(.retry)
    }
}

class HogeStateMachine {
    private let akerunDoorInput: AkerunDoorInput
    
    // input
    let action = PassthroughSubject<HogeAction, Never>()
    
    // output
    var state: PassthroughSubject<HogeState, Never> { self._state }
    
    private let _state = PassthroughSubject<HogeState, Never>()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(akerunDoorInput: AkerunDoorInput) {
        self.akerunDoorInput = akerunDoorInput
        
        action
            .combineLatest(_state)
            .sink { action, state in
                switch action {
                case .initialLoading:
                    if case .None = state {
                        self._state.send(.LoadingFetchState)
//                        self.hogeManager.fetchStateWithBle.send(())
                    }
                case .changeRemoteFlg(let remoteFlg):
                    
                    self._state.send(.LoadingFetchState)
//                    remoteFlg
//                    ? self.hogeManager.fetchStateWithWebApi.send(())
//                    : self.hogeManager.fetchStateWithBle.send(())
                case .retry:
                    switch state {
                    case .FailFetchState:
                        self._state.send(.LoadingFetchState)
//                        self.hogeManager.fetchStateWithBle.send(())
                    case .FailUnLock:
                        self._state.send(.LoadingUnLock)
//                        self.hogeManager.open.send(())
                    case .FailLock:
                        self._state.send(.LoadingLock)
//                        self.hogeManager.close.send(())
                    default:
                        break
                    }
                case .tryUnLock:
                    self._state.send(.LoadingUnLock)
//                    self.hogeManager.open.send(())
                case .tryLock:
                    self._state.send(.LoadingLock)
//                    self.hogeManager.close.send(())
                }
            }
            .store(in: &cancellables)
    }
}

extension HogeStateMachine: HogeDoorDelegate {
    
}
    

enum HogeState {
    case None
    case LoadingFetchState
    case SuccessFetchState(Bool)
    case FailFetchState
    
    case LoadingUnLock
    case SuccessUnLock
    case FailUnLock
    
    case LoadingLock
    case SuccessLock
    case FailLock
}

enum HogeAction {
    case initialLoading
    case changeRemoteFlg(Bool)
    case tryUnLock
    case tryLock
    case retry
}
