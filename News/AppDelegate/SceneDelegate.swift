import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let ws = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: ws.coordinateSpace.bounds)
        window?.windowScene = ws
        window?.rootViewController = UINavigationController(rootViewController: MasterViewController())
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
}

