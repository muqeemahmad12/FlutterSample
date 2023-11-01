
import DocereeAdSdk
import CommonCrypto

class HcpManager: NSObject {
    
    override init() {
        super.init()
    }
    
    func shared() -> HcpManager {
        return HcpManager()
    }
    func sendAppKey(appKey: String) {
        DocereeMobileAds.setApplicationKey(appKey)
    }

  func sendHcpProfile() {
    let email: String = "john.doe@example.com"
//        let nip: String = "ABCDE12345"
    let gmc: String = "1234567"
    
    //Passing hcp peofile
    let hcp = Hcp.HcpBuilder()
        .setFirstName(firstName: "John")
        .setLastName(lastName: "Doe")
        .setSpecialization(specialization: "Anesthesiology")
        .setOrganisation(organisation: "Apollo")
        .setCity(city: "Mumbai")
        .setZipCode(zipCode: "400004")
        .setGender(gender: "Male")
        .setGmc(gmc: gmc)
        .setHashedGMC(hashedGMC: gmc.sha256())
        .setMciRegistrationNumber(mciRegistrationNumber: "ABCDE12345")
//            .setNpi(npi: nip)
//            .setHashedNPI(hashedNPI: nip.sha256())
        .setEmail(email: email)
        .setHashedEmail(hashedEmail: email.sha256())
        .setMobile(mobile: "9999999999")
        .build()
    
    DocereeMobileAds.login(with: hcp)
  }

}

extension String {
    func sha256() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        let hash = data.withUnsafeBytes{(bytes: UnsafePointer<Data>) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            CC_SHA256(bytes, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map{ String(format: "%02x", $0) }.joined()
    }
}
