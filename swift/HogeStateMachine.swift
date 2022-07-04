import Foundation
import Combine

enum DoorState {
    case None
    case Loading
    case Open
    case Close
    case Retry
}

class HogeViewModel: ObservableObject {
    private let stateMachine: HogeStateMachine
    
    @Published var doorState: DoorState = .None

    @Published var retryFlg: Bool = false
    @Published var tryOpenFlg: Bool = false
    @Published var tryCloseFlg: Bool = false
    @Published var remoteFlg: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(stateMachine: HogeStateMachine) {
        self.stateMachine = stateMachine
        
        $remoteFlg
            .sink { remoteFlg in
                stateMachine.action.send(.changeRemoteFlg(remoteFlg))
                self.remoteFlg.toggle()
            }
            .store(in: &cancellables)
        
        $tryOpenFlg
            .sink { openFlg in
                if openFlg {
                    stateMachine.action.send(.tryOpen)
                    self.tryOpenFlg.toggle()
                }
            }
            .store(in: &cancellables)
        
        $tryCloseFlg
            .sink { closeFlg in
                if closeFlg {
                    stateMachine.action.send(.tryClose)
                    self.tryCloseFlg.toggle()
                }
            }
            .store(in: &cancellables)
        
        $retryFlg
            .sink { retryFlg in
                if retryFlg {
                    stateMachine.action.send(.retry)
                    self.retryFlg.toggle()
                }
            }
            .store(in: &cancellables)
        
        bindStateMachine()
    }
    
    private func bindStateMachine() {
        stateMachine.state
            .sink { state in
                switch state {
                case .None:
                    break
                case .LoadingFetchState, .LoadingOpen, .LoadingClose:
                    self.doorState = .Loading
                    
                case .SuccessFetchState(let isOpen):
                    self.doorState = isOpen ? .Open : .Close
                    
                case .FailFetchState:
                    self.doorState = .Retry
                    
                case .SuccessOpen:
                    self.doorState = .Loading
                    
                case .FailOpen:
                    self.doorState = .Retry
                    
                case .SuccessClose:
                    self.doorState = .Close
                    
                case .FailClose:
                    self.doorState = .Retry
                }
            }
            .store(in: &cancellables)
    }
}

class HogeStateMachine {
    private let hogeManager: HogeManager
    
    // input
    let action = PassthroughSubject<HogeAction, Never>()
    
    // output
    var state: PassthroughSubject<HogeState, Never> { self._state }
    
    private let _state = PassthroughSubject<HogeState, Never>()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(manager: HogeManager) {
        self.hogeManager = manager
        
        action
            .combineLatest(_state)
            .sink { action, state in
                switch action {
                case .initialLoading:
                    if case .None = state {
                        self._state.send(.LoadingFetchState)
                        self.hogeManager.fetchStateWithBle.send(())
                    }
                case .changeRemoteFlg(let remoteFlg):
                    // どう制御するか
                    
                    self._state.send(.LoadingFetchState)
                    remoteFlg
                    ? self.hogeManager.fetchStateWithWebApi.send(())
                    : self.hogeManager.fetchStateWithBle.send(())
                case .retry:
                    switch state {
                    case .FailFetchState:
                        self._state.send(.LoadingFetchState)
                        self.hogeManager.fetchStateWithBle.send(()) // BLE, Webどっち？
                    case .FailOpen:
                        self._state.send(.LoadingOpen)
                        self.hogeManager.open.send(())
                    case .FailClose:
                        self._state.send(.LoadingClose)
                        self.hogeManager.close.send(())
                    default:
                        break
                    }
                case .tryOpen:
                    self._state.send(.LoadingOpen)
                    self.hogeManager.open.send(())
                case .tryClose:
                    self._state.send(.LoadingClose)
                    self.hogeManager.close.send(())
                }
            }
            .store(in: &cancellables)
        
        bindManagerOutput()
    }
    
    private func bindManagerOutput() {
        
        hogeManager.openResult
            .sink { isSuccess in
                isSuccess
                ? self._state.send(.SuccessOpen)
                : self._state.send(.FailClose)
            }
            .store(in: &cancellables)
        
        hogeManager.closeResult
            .sink { isSuccess in
                isSuccess
                ? self._state.send(.SuccessClose)
                : self._state.send(.FailClose)
            }
            .store(in: &cancellables)
        
        hogeManager.stateResultWithApi
            .merge(with: hogeManager.stateResultWithBle)
            .sink { isOpen in
                self._state.send(.SuccessFetchState(isOpen))
            }
            .store(in: &cancellables)
    }
}

enum HogeState {
    case None
    case LoadingFetchState
    case SuccessFetchState(Bool)
    case FailFetchState
    
    case LoadingOpen
    case SuccessOpen
    case FailOpen
    
    case LoadingClose
    case SuccessClose
    case FailClose
}

enum HogeAction {
    case initialLoading
    case changeRemoteFlg(Bool)
    case retry
    case tryOpen
    case tryClose
}

class HogeManager {
    // input
    let fetchStateWithBle = PassthroughSubject<Void, Never>()
    let fetchStateWithWebApi = PassthroughSubject<Void, Never>()
    let open = PassthroughSubject<Void, Never>()
    let close = PassthroughSubject<Void, Never>()
    
    // output
    let stateResultWithBle = PassthroughSubject<Bool, Never>()
    let stateResultWithApi = PassthroughSubject<Bool, Never>()
    let openResult = PassthroughSubject<Bool, Never>()
    let closeResult = PassthroughSubject<Bool, Never>()
}
