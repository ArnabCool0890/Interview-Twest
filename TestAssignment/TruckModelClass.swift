// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try Welcome(json)

import Foundation
import UIKit
// MARK: - TruckModel
struct TruckModel: Codable {
    var responseCode: ResponseCode?
    var data: [TruckModels]?
}

// MARK: Truck convenience initializers and mutators

extension TruckModel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TruckModel.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        responseCode: ResponseCode?? = nil,
        data: [TruckModels]?? = nil
    ) -> TruckModel {
        return TruckModel(
            responseCode: responseCode ?? self.responseCode,
            data: data ?? self.data
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Datum
struct TruckModels: Codable {
    var id, companyID, truckTypeID, truckSizeID: Int?
    var truckNumber: String?
    var transporterID, trackerType: Int?
    var imeiNumber, simNumber: String?
    var name: Name?
    var password: Password?
    var createTime: Int?
    var deactivated, breakdown: Bool?
    var lastWaypoint: LastWaypoint?
    var lastRunningState: LastRunningState?
    var durationInsideSite: Int?
    var fuelSensorInstalled, externalTruck: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case companyID = "companyId"
        case truckTypeID = "truckTypeId"
        case truckSizeID = "truckSizeId"
        case truckNumber
        case transporterID = "transporterId"
        case trackerType, imeiNumber, simNumber, name, password, createTime, deactivated, breakdown, lastWaypoint, lastRunningState, durationInsideSite, fuelSensorInstalled, externalTruck
    }
}

// MARK: Datum convenience initializers and mutators

extension TruckModels {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TruckModels.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        companyID: Int?? = nil,
        truckTypeID: Int?? = nil,
        truckSizeID: Int?? = nil,
        truckNumber: String?? = nil,
        transporterID: Int?? = nil,
        trackerType: Int?? = nil,
        imeiNumber: String?? = nil,
        simNumber: String?? = nil,
        name: Name?? = nil,
        password: Password?? = nil,
        createTime: Int?? = nil,
        deactivated: Bool?? = nil,
        breakdown: Bool?? = nil,
        lastWaypoint: LastWaypoint?? = nil,
        lastRunningState: LastRunningState?? = nil,
        durationInsideSite: Int?? = nil,
        fuelSensorInstalled: Bool?? = nil,
        externalTruck: Bool?? = nil
    ) -> TruckModels {
        return TruckModels(
            id: id ?? self.id,
            companyID: companyID ?? self.companyID,
            truckTypeID: truckTypeID ?? self.truckTypeID,
            truckSizeID: truckSizeID ?? self.truckSizeID,
            truckNumber: truckNumber ?? self.truckNumber,
            transporterID: transporterID ?? self.transporterID,
            trackerType: trackerType ?? self.trackerType,
            imeiNumber: imeiNumber ?? self.imeiNumber,
            simNumber: simNumber ?? self.simNumber,
            name: name ?? self.name,
            password: password ?? self.password,
            createTime: createTime ?? self.createTime,
            deactivated: deactivated ?? self.deactivated,
            breakdown: breakdown ?? self.breakdown,
            lastWaypoint: lastWaypoint ?? self.lastWaypoint,
            lastRunningState: lastRunningState ?? self.lastRunningState,
            durationInsideSite: durationInsideSite ?? self.durationInsideSite,
            fuelSensorInstalled: fuelSensorInstalled ?? self.fuelSensorInstalled,
            externalTruck: externalTruck ?? self.externalTruck
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LastRunningState
struct LastRunningState: Codable {
    var truckID, stopStartTime, truckRunningState: Int?
    var lat, lng: Double?
    var stopNotficationSent: Int?

    enum CodingKeys: String, CodingKey {
        case truckID = "truckId"
        case stopStartTime, truckRunningState, lat, lng, stopNotficationSent
    }
}

// MARK: LastRunningState convenience initializers and mutators

extension LastRunningState {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LastRunningState.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        truckID: Int?? = nil,
        stopStartTime: Int?? = nil,
        truckRunningState: Int?? = nil,
        lat: Double?? = nil,
        lng: Double?? = nil,
        stopNotficationSent: Int?? = nil
    ) -> LastRunningState {
        return LastRunningState(
            truckID: truckID ?? self.truckID,
            stopStartTime: stopStartTime ?? self.stopStartTime,
            truckRunningState: truckRunningState ?? self.truckRunningState,
            lat: lat ?? self.lat,
            lng: lng ?? self.lng,
            stopNotficationSent: stopNotficationSent ?? self.stopNotficationSent
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - LastWaypoint
struct LastWaypoint: Codable {
    var id: Int?
    var lat, lng: Double?
    var createTime, accuracy, bearing, truckID: Int?
    var speed: Double?
    var updateTime: Int?
    var ignitionOn: Bool?
    var odometerReading: Double?
    var batteryPower: Bool?
    var fuelLevel, batteryLevel: Int?

    enum CodingKeys: String, CodingKey {
        case id, lat, lng, createTime, accuracy, bearing
        case truckID = "truckId"
        case speed, updateTime, ignitionOn, odometerReading, batteryPower, fuelLevel, batteryLevel
    }
}

// MARK: LastWaypoint convenience initializers and mutators

extension LastWaypoint {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LastWaypoint.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int?? = nil,
        lat: Double?? = nil,
        lng: Double?? = nil,
        createTime: Int?? = nil,
        accuracy: Int?? = nil,
        bearing: Int?? = nil,
        truckID: Int?? = nil,
        speed: Double?? = nil,
        updateTime: Int?? = nil,
        ignitionOn: Bool?? = nil,
        odometerReading: Double?? = nil,
        batteryPower: Bool?? = nil,
        fuelLevel: Int?? = nil,
        batteryLevel: Int?? = nil
    ) -> LastWaypoint {
        return LastWaypoint(
            id: id ?? self.id,
            lat: lat ?? self.lat,
            lng: lng ?? self.lng,
            createTime: createTime ?? self.createTime,
            accuracy: accuracy ?? self.accuracy,
            bearing: bearing ?? self.bearing,
            truckID: truckID ?? self.truckID,
            speed: speed ?? self.speed,
            updateTime: updateTime ?? self.updateTime,
            ignitionOn: ignitionOn ?? self.ignitionOn,
            odometerReading: odometerReading ?? self.odometerReading,
            batteryPower: batteryPower ?? self.batteryPower,
            fuelLevel: fuelLevel ?? self.fuelLevel,
            batteryLevel: batteryLevel ?? self.batteryLevel
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum Name: String, Codable {
    case empty = ""
    case sukhi = "sukhi"
}

enum Password: String, Codable {
    case empty = ""
    case sukhi123 = "sukhi123"
}

// MARK: - ResponseCode
struct ResponseCode: Codable {
    var responseCode: Int?
    var message: String?
}

// MARK: ResponseCode convenience initializers and mutators

extension ResponseCode {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ResponseCode.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        responseCode: Int?? = nil,
        message: String?? = nil
    ) -> ResponseCode {
        return ResponseCode(
            responseCode: responseCode ?? self.responseCode,
            message: message ?? self.message
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

//extension UIApplication {
//    var statusBarView: UIView? {
//        if responds(to: Selector(("statusBar"))) {
//            return value(forKey: "statusBar") as? UIView
//        }
//        return nil
//    }
//}

//extension UIApplication {
//
//   var statusBarView: UIView? {
//      return value(forKey: "statusBar") as? UIView
//    }
//
//}
