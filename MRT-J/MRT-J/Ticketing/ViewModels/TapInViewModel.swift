//
//  TapInViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation
import CoreLocation

class TapInViewModel: TicketingViewModel {
    
    private var tvm: TicketingViewModel
    
    init(tvm: TicketingViewModel) {
        self.tvm = tvm
        super.init()
        tvm.clvm.locationManager.requestLocation()
        generateDataForQRCode(name: super.name, email: super.email)
    }
    
    func generateDataForQRCode(name: String, email: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())
        let latitude = tvm.clvm.location?.coordinate.latitude.description
        let longitude = tvm.clvm.location?.coordinate.latitude.description
        let ticket = Ticket(name: name, email: email, currentTime: currentTime, latitude: latitude ?? "nil", longitude: longitude ?? "nil")
        tvm.ticketsAppend(ticket: ticket)
        guard let jsonData = generateJSONData(ticket: ticket) else { return }
        tvm.qrCodeImage = super.aqrvm.generateQRCode(apiEndpoint: "https://3691-103-154-141-89.ngrok-free.app/api/put/ticket/", requestData: jsonData)
    }
    
    private func generateJSONData(ticket: Ticket) -> Data? {
        let jsonDict: [String: Any] = [
            "name": ticket.name,
            "email": ticket.email,
            "tap_in_id": ticket.id.uuidString,
            "tap_in_time": ticket.currentTime,
            "tap_in_latitude": ticket.latitude,
            "tap_in_longitude": ticket.longitude,
            "tap_in_station": "DummyStation"
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
            return jsonData
        } catch {
            print("Error generating JSON data: \(error.localizedDescription)")
            return nil
        }
    }
    
}
