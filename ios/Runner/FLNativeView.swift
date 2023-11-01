//
//  FLNativeView.swift
//  Runner
//
//  Created by Muqeem.Ahmad on 13/06/23.
//

import Flutter
import UIKit
import DocereeAdSdk

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {

    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    
    var adView: DocereeAdView!
    var adSize: String = "320 x 50"
    var adUnitId: String = "DOC-18-1"
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        addCreation()
        _view.backgroundColor = UIColor.red
        _view.frame = CGRect(x: 10, y: 100, width: 200, height: 200)
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        _view.addSubview(nativeLabel)
    }
    
    
    // MARK: - Ads
    
    func addCreation() {
        adView = DocereeAdView(with: adSize, and: CGPoint(x: 50, y: 50), adPosition: .custom)
        adView.docereeAdUnitId = adUnitId
//        adView.delegate = self
        adView.frame = CGRect(x: 0, y: 0, width: adView.frame.width, height: adView.frame.height) //These two lines are required in case of custom position
//        adView.center.x = self.view.center.x
        adView.load(DocereeAdRequest())
        addBannerViewtoView(adView)
    }
    
    private func addBannerViewtoView(_ bannerAdView: DocereeAdView) {
        _view.addSubview(adView)
    }
    
    func docereeAdViewDidReceiveAd(_ docereeAdView: DocereeAdView) {
        print("ad received")
    }
    
    func docereeAdView(_ docereeAdView: DocereeAdView, didFailToReceiveAdWithError error: DocereeAdRequestError) {
        print("ad \(error)")
    }
    
    func docereeAdViewWillPresentScreen(_ docereeAdView: DocereeAdView) {
        print("ad will present screen")
    }
    
    func docereeAdViewWillDismissScreen(_ docereeAdView: DocereeAdView) {
        print("ad will dismiss")
    }
    
    func docereeAdViewDidDismissScreen(_ docereeAdView: DocereeAdView) {
        print("ad did dismiss")
    }
    
    func docereeAdViewWillLeaveApplication(_ docereeAdView: DocereeAdView) {
        print("ad will leave application")
    }
}
    
