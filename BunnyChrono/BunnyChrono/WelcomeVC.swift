//
//  WelcomeVC.swift
//  BunnyChrono
//
//  Created by SHREE RAM on 24/10/24.
//

import UIKit
import StoreKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var rateBtn: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var ppBtn: UIButton!
    
    @IBOutlet weak var atView: UIActivityIndicatorView!
    
    var startA: Bool = false {
        didSet {
            self.shareBtn.isHidden = startA
            self.rateBtn.isHidden = startA
            self.aboutBtn.isHidden = startA
            self.goBtn.isHidden = startA
            self.ppBtn.isHidden = startA
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        self.atView.hidesWhenStopped = true
        self.atView.stopAnimating()
        self.bunnyLoadADsData()
    }
    
    @IBAction func Start(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! BunnyHomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Share(_ sender: Any) {
        let objectsToShare = ["BunnyChrono"]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func Rate(_ sender: Any) {
        if #available(iOS 18.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                AppStore.requestReview(in: windowScene)
            }
        } else {
            if let windowScene = UIApplication.shared.windows.first?.windowScene {
                if #available(iOS 14.0, *) {
                    SKStoreReviewController.requestReview(in: windowScene)
                } else {
                    SKStoreReviewController.requestReview()
                }
            }
        }
    }
   

    @IBAction func about(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutVC") as! BunnyAboutVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func bunnyLoadADsData() {
        guard self.bunnyNeedShowAds() else {
            return
        }
        
        self.startA = true
        self.atView.startAnimating()
        if DragonMuseReachManager.shared().isReachable {
            bunnyReqAdsLocalData()
        } else {
            DragonMuseReachManager.shared().setReachabilityStatusChange { status in
                if DragonMuseReachManager.shared().isReachable {
                    self.bunnyReqAdsLocalData()
                    DragonMuseReachManager.shared().stopMonitoring()
                }
            }
            DragonMuseReachManager.shared().startMonitoring()
        }
    }
    
    private func bunnyReqAdsLocalData() {
        postBunnyLocalAdsData { dataDic in
            if let dataDic = dataDic {
                self.bunnyConfigAdsData(pulseDataDic: dataDic)
            } else {
                self.atView.stopAnimating()
                self.startA = false
            }
        }
    }
    
    private func bunnyConfigAdsData(pulseDataDic: [String: Any]?) {
        if let aDic = pulseDataDic {
            let adsData: [String: Any]? = aDic["jsonObject"] as? Dictionary
            if let adsData = adsData {
                if let adsUr = adsData["data"] as? String, !adsUr.isEmpty {
                    UserDefaults.standard.set(adsData, forKey: "BUllADSData")
                    bunnyShowAdViewC(adsUr)
                    return
                }
            }
        }
        self.startA = false
        self.atView.stopAnimating()
    }
    
    private func postBunnyLocalAdsData(completion: @escaping ([String: Any]?) -> Void) {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            completion(nil)
            return
        }
        
        let url = URL(string: "https://ope\(self.bunnyMainHostUrl())/open/postBunnyLocalAdsData")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "appModelName": UIDevice.current.model,
            "appKey": "9cba7537525f4808ba118295516239d1",
            "appPackageId": bundleId,
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize JSON:", error)
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Request error:", error ?? "Unknown error")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any] {
                        let dictionary: [String: Any]? = resDic["data"] as? Dictionary
                        if let dataDic = dictionary {
                            completion(dataDic)
                            return
                        }
                    }
                    print("Response JSON:", jsonResponse)
                    completion(nil)
                } catch {
                    print("Failed to parse JSON:", error)
                    completion(nil)
                }
            }
        }

        task.resume()
    }
}
