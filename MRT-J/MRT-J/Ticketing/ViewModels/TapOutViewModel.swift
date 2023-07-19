//
//  TapOutViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation
import CoreLocation

class TapOutViewModel: TappingViewModel {
    
    private var ticket: Ticket
    
    init(name: String, email: String, ticket: Ticket) {
        self.ticket = ticket
        super.init(name: name, email: email)
        generateDataForQRCode(name: super.name, email: super.email)
        startTimer()
    }
    
    deinit {
        super.stopTimer()
    }
    
    func generateDataForQRCode(name: String, email: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())
        let latitude = super.clvm.location?.coordinate.latitude.description
        let longitude = super.clvm.location?.coordinate.latitude.description
        ticket.tap_out_id = UUID().uuidString
        ticket.tap_out_time = currentTime
        ticket.tap_out_latitude = latitude
        ticket.tap_out_longitude = longitude
        ticket.tap_out_station = "DummyStation2"
        guard let jsonData = generateJSONData(ticket: ticket) else { return }
        super.qrCodeImage = super.qrg.generateQRCode(apiEndpoint: "https://3691-103-154-141-89.ngrok-free.app/api/put/ticket/", requestData: jsonData)
    }
    
    private func generateJSONData(ticket: Ticket) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(ticket)
            return jsonData
        } catch {
            print("Error generating JSON data: \(error.localizedDescription)")
            return nil
        }
    }
}

extension TapOutViewModel: TappingProtocol {
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            self?.generateDataForQRCode(name: self?.name ?? "nil", email: self?.email ?? "nil")
            self?.objectWillChange.send()
        }
    }
}
