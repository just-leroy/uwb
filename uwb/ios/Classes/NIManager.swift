//
//  NIManager.swift
//  uwb
//
//  Created by Leroy on 10/02/2022.
//

import Foundation
import NearbyInteraction

@available(iOS 14.0, *)
class NIManager: NSObject, NISessionDelegate, ObservableObject {
    
//    static let shared = NIManager()
    
    override init() {
        
    }
    
    @Published var distance: String = "0"
    var nearbyObjects: NINearbyObject?
    var session: NISession?
    var discoveryToken: NIDiscoveryToken?
    
    func start() {
        session = NISession()
        session?.delegate = self
        discoveryToken = session?.discoveryToken

//        sendDiscoveryTokenToMyPeer(peer, mydiscoveryToken)
//
//        let peerDiscoveryToken = ...
//
//        let config = NINearbyPeerConfiguration(peerToken: peerDiscoveryToken)
//
//        session.run(config)

    }
    //MARK: - Nearby Interaction Functions
      
    func startSession(data: Data){
        print("Trying to setup ni-connection")
        guard let token = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data) else {
            fatalError("Unexpectedly failed to encode discovery token.")
        }
        let configuration = NINearbyPeerConfiguration(peerToken: token)
        session?.run(configuration)
    }
    
    // MARK: - NISessionDelegate functions
    
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        print(nearbyObjects)
//        self.nearbyObjects = nearbyObjects
        distance = String(nearbyObjects.first?.distance ?? 0)
//        SwiftUwbPlugin.channel?.invokeMethod("updateLocation", arguments: "testmessage")
        SwiftUwbPlugin.startLocationUpdates(arguments: distance)
    }
    
    func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
        
    }
    
    func sessionWasSuspended(_ session: NISession) {
        
    }
    
    func sessionSuspensionEnded(_ session: NISession) {
        
    }
    
    func session(_ session: NISession, didInvalidateWith error: Error) {
        
    }
}
