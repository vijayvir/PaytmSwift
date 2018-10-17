//
//  ViewController.swift
//  PayTmDemo
//
//  Created by Nitish Sharma on 15/10/18.
//  Copyright © 2018 vijayvir Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var merchant:PGMerchantConfiguration!
    override func viewDidLoad() {
        super.viewDidLoad()
        setMerchant()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionDemoPayment(_ sender: Any) {
        createPayment()
    }
    
}

extension ViewController : PGTransactionDelegate {
    func createPayment(){
        
        var orderDict = [String : String]()
        orderDict["MID"] = "dsdsds";//paste here your merchant id   //mandatory
        orderDict["CHANNEL_ID"] = "WAP"; // paste here channel id                       // mandatory
        orderDict["INDUSTRY_TYPE_ID"] = "Retail";//paste industry type              //mandatory
        orderDict["WEBSITE"] = "APPSTAGING";// paste website                            //mandatory
        
        orderDict["TXN_AMOUNT"] = "10"; // amount to charge                      // mandatory
        orderDict["ORDER_ID"] = "ORD0001468"; //"\(Date().timeIntervalSince1970)";//change order id every time on new
        orderDict["REQUEST_TYPE"] = "DEFAULT";// remain same
        orderDict["CUST_ID"] = "CUST0001454"; // change acc. to your database user/customers
        
        orderDict["CALLBACK_URL"] = "http://.com/api/Paytm_App/verifyChecksum.php"
        
        let pgOrder = PGOrder(params: orderDict )
        
        
        
        
        let transaction = PGTransactionViewController.init(transactionFor: pgOrder)
        
        transaction!.serverType = eServerTypeStaging
        transaction!.merchant = self.merchant
        transaction!.loggingEnabled = true
        transaction!.delegate = self
        self.present(transaction!, animated: true, completion: {
            
            
            
            
        })
        
        return
        
        
        
        
        
    }
    func setMerchant(){
        merchant  = PGMerchantConfiguration.default()!
        //user your checksum urls here or connect to paytm developer team for this or use default urls of paytm
        merchant.checksumGenerationURL = "http://ee.com/api/Paytm_App/generateChecksum.php";
        merchant.checksumValidationURL = "http://ee.com/api/Paytm_App/verifyChecksum.php";
        // Set the client SSL certificate path. Certificate.p12 is the certificate which you received from Paytm during the registration process. Set the password if the certificate is protected by a password.
        merchant.clientSSLCertPath = nil; //[[NSBundle mainBundle]pathForResource:@"Certificate" ofType:@"p12"];
        merchant.clientSSLCertPassword = nil; //@"password";
        
        //configure the PGMerchantConfiguration object specific to your requirements
        merchant.merchantID = "Fet03002075022972";//paste here your merchant id  //mandatory
        merchant.website = "APPSTAGING";//mandatory
        merchant.industryID = "Retail";//mandatory
        merchant.channelID = "WAP"; //provided by PG WAP //mandatory
    }
    
    func showAlert(title:String,message:String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func didSucceedTransaction(_ controller: PGTransactionViewController!, response: [AnyHashable : Any]!) {
        print(response)
        showAlert(title: "Transaction Successfull", message: NSString.localizedStringWithFormat("Response- %@", response) as String)
        
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // change 2 to desired number of seconds
//            // Your code with delay
//
//            controller.dismiss(animated: true) {
//
//            }
//
//        }
        
        
    }
    func errorMisssingParameter(_ controller: PGTransactionViewController!, error: Error!) {
        print("Parameters")
     //   self.removeController(controller)
    }
    
    func didFailTransaction(_ controller: PGTransactionViewController!, error: Error!, response: [AnyHashable : Any]!) {
        print(error)
        showAlert(title: "Transaction Failed", message: error.localizedDescription)
    }
    func didCancelTransaction(_ controller: PGTransactionViewController!, error: Error!, response: [AnyHashable : Any]!) {
        
        showAlert(title: "Transaction Cancelled", message: error.localizedDescription)
        
    }
    
    func didFinishCASTransaction(_ controller: PGTransactionViewController!, response: [AnyHashable : Any]!) {
        print(response)
        showAlert(title: "cas", message: "")
    }
    
}
