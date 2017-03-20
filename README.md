# Flow
Decouple your View Controllers with Flow Controllers

```swift
SignUpStep1VC.self --> SignUpStep2VC.self
```
- [x] Decouples ViewControllers between them
- [x] Leaves your View Controllers Clean
- [x] Faster Compile times (less dependencies)

## Declare your flow
Picture a `Flow` visually exactly like a Storyboard.

You have :

- An `initialViewController` where the flow starts.
- `Links` between ViewControllers `A` --> `B`.
- And `Data` that you can pass between them `A` -- `onEvent(data)` --> `B(data)`

### A SignUp flow

```swift
class SignupFlow: Flow {

    override init() {
        super.init()
        initialViewController = SignUpStep1VC()

        register(
            SignUpStep1VC.self --> { SignUpStep2VC(user: $0) },
            SignUpStep2VC.self --> { SignUpStep3VC(user: $0) },
            SignUpStep3VC.self --> { SignUpStep4VC(user: $0) }
        )
    }
}
```
Here each View Controllers passes the `User` model around.


## Start it !
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions
                 launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.start(flow: SignupFlow()) // Start Flow!
    window?.makeKeyAndVisible()
    return true
}
```
