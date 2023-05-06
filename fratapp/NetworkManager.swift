//
//  NetworkManager.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var url_string = "http://127.0.0.1:8000"
    
    func getAllEvents(completion: @escaping ([Event]) -> Void) {
        var request = URLRequest(url: URL(string: url_string + "/event/is-public/")!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(EventResponse.self, from: data)
                    completion(response.events)
                }
                catch (let error) {
                    print(String(describing: error))
                }
            }
        }
        
        task.resume()
    }
    
    func createEvent(name: String, description: String, start: String, end: String, location: String, is_public: Bool, hosting_fraternities: [Fraternity], completion: @escaping (Event) -> Void) {
        var request = URLRequest(url: URL(string: url_string + "/event/create/")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "fraternity_id": hosting_fraternities[0].id,
            "name" : name,
            "description" : description,
            "start_date" : start,
            "end_date" : end,
            "is_public" : is_public,
            "location" : location
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Event.self, from: data)
                    completion(response)
                } catch (let error){
                    print(error.localizedDescription)
                }
            }
        }

        task.resume()
    }

    func deleteEvent(id: Int, completion: @escaping (Event) -> Void) {
        var request = URLRequest(url: URL(string: url_string + "/event/" + String(id) + "/delete/")!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Event.self, from: data)
                    completion(response)
                } catch (let error){
                    print(error.localizedDescription)
                }
            }
        }

        task.resume()
    }

    func updateEvent(id: Int, name: String, description: String, start: String, end: String, location: String, is_public: Bool, hosting_fraternities: [Fraternity], completion: @escaping (Event) -> Void) {
        var request = URLRequest(url: URL(string: url_string + "/event/" + String(id) + "/edit/")!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "name" : name,
            "description" : description,
            "start_date" : start,
            "end_date" : end,
            "location" : location,
            "is_public" : is_public
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Event.self, from: data)
                    completion(response)
                } catch (let error){
                    print(error.localizedDescription)
                }
            }
        }

        task.resume()
    }
    
    func getUpcomingEvents(user_id: Int, completion: @escaping ([Event]) -> Void) {
        var request = URLRequest(url: URL(string: url_string + "/event/" + String(user_id) + "/attending/")!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(EventResponse.self, from: data)
                    completion(response.events)
                }
                catch (let error) {
                    print(String(describing: error))
                }
            }
        }
        
        task.resume()
    }
    
    func getInvitedEvents(user_id: Int, completion: @escaping ([Event]) -> Void) {
        var request = URLRequest(url: URL(string: url_string + "/event/" + String(user_id) + "/invited/")!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(EventResponse.self, from: data)
                    completion(response.events)
                }
                catch (let error) {
                    print(String(describing: error))
                }
            }
        }
        
        task.resume()
    }
    
    func createInvite(sender_id: Int, receiver_id: Int, event_id: Int, fraternity_id: Int, completion: @escaping (Invitation) -> Void) {
        var request = URLRequest(url: URL(string: url_string + "/invitation/create/")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "sender_id" : sender_id,
            "receiver_id" : receiver_id,
            "event_id" : event_id,
            "fraternity_id" : fraternity_id,
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Invitation.self, from: data)
                    completion(response)
                } catch (let error){
                    print(error.localizedDescription)
                }
            }
        }

        task.resume()
    }
    
    func acceptInvite(receiver_id: Int, event_id: Int, completion: @escaping (Invitation) -> Void) {
        var request = URLRequest(url: URL(string: url_string + "/invitation/accept/")!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "receiver_id" : receiver_id,
            "event_id" : event_id,
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Invitation.self, from: data)
                    completion(response)
                } catch (let error){
                    print(error.localizedDescription)
                }
            }
        }

        task.resume()
    }
    
    func rejectInvite(receiver_id: Int, event_id: Int, completion: @escaping (Invitation) -> Void) {
        var request = URLRequest(url: URL(string: url_string + "/invitation/reject/")!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "receiver_id" : receiver_id,
            "event_id" : event_id,
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Invitation.self, from: data)
                    completion(response)
                } catch (let error){
                    print(error.localizedDescription)
                }
            }
        }

        task.resume()
    }
}
