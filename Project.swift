import ProjectDescription

let targets: [Target] = [
    Target(
        name: "Portolan",
        platform: .iOS,
        product: .framework,
        bundleId: "com.seunghun.portolan",
        deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
        sources: ["Portolan/Sources/**"],
        dependencies: []
    ),
//    Target(
//        name: "PortolanDemo",
//        platform: .iOS,
//        product: .app,
//        bundleId: "com.seunghun.portolan.demo",
//        deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
//        infoPlist: .extendingDefault(
//            with: [
//                "UILaunchStoryboardName": "LaunchScreen",
//                "NSLocationWhenInUseUsageDescription": true,
//            ]
//        ),
//        sources: ["PortolanDemo/Sources/**"],
//        resources: ["PortolanDemo/Resources/**"],
//        dependencies: [
//            .target(name: "Portolan")
//        ],
//        settings: .settings(
//            base: ["DEVELOPMENT_TEAM": "5HZQ3M82FA"],
//            configurations: [],
//            defaultSettings: .recommended
//        )
//    )
]

let project = Project(
    name: "Portolan",
    organizationName: "seunghun",
    targets: targets
)
