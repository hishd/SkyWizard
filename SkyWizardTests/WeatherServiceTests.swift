//
//  WeatherServiceTests.swift
//  SkyWizardTests
//
//  Created by Hishara Dilshan on 2024-05-16.
//

import XCTest
import CoreLocation
@testable import SkyWizard
import Combine

final class WeatherServiceTests: XCTestCase {

    var sut: WeatherService!
    
    func testWeatherResultMock() async throws {
        sut = MockWeatherService()
        let location: CLLocation = CLLocation(latitude: CLLocationDegrees(), longitude: CLLocationDegrees())
        let result = try await sut.getWeather(for: location)
        
        let expectedTime = "2024-05-16T18:30"
        let expectedTimeZone = "Europe/London"
        XCTAssertEqual(result.current.time, expectedTime)
        XCTAssertEqual(result.timezone, expectedTimeZone)
    }
    
    func testWeatherResultRemoteAsync() async throws {
        sut = OpenMetroWeatherService()
        let expectedTimeZone = "Europe/London"
        let expectedTimeAbbriviation = "BST"
        let lat: CLLocationDegrees = 52.260002
        let lon: CLLocationDegrees = -0.8800001
        let location: CLLocation = CLLocation(latitude: lat, longitude: lon)
        
        let result = try await sut.getWeather(for: location)
        
        XCTAssertEqual(result.timezone, expectedTimeZone)
        XCTAssertEqual(result.timezoneAbbreviation, expectedTimeAbbriviation)
    }
    
    func testWeatherResultRemote() {
        sut = OpenMetroWeatherService()
        let expectation = expectation(description: "Fetch WeatherResult")
        let expectedTimeZone = "Europe/London"
        let expectedTimeAbbriviation = "BST"
        let lat: CLLocationDegrees = 52.260002
        let lon: CLLocationDegrees = -0.8800001
        let location: CLLocation = CLLocation(latitude: lat, longitude: lon)
        
        let cancellable: AnyCancellable = sut.getWeather(for: location)
            .receive(on: DispatchQueue.global())
            .sink { completion in
                switch completion {
                case .finished:
                    print("Execution Successful")
                case .failure(let error):
                    XCTFail("Failed to fetch weather result. Error: \(error.localizedDescription)")
                }
                expectation.fulfill()
            } receiveValue: { result in
                XCTAssertEqual(result.timezone, expectedTimeZone)
                XCTAssertEqual(result.timezoneAbbreviation, expectedTimeAbbriviation)
            }
        
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
