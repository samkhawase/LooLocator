//
//  NetworkRequest.swift
//  LooLocator
//
//  Created by Sam Khawase on 15.02.20.
//  Copyright © 2020 LooLocator. All rights reserved.
//
import Foundation

//typealias CompletionBlock = (_ success: Bool, _ object: AnyObject?) -> ()

protocol NetworkRequestProviding {
    
    // The model that the request deals with
    associatedtype SerializedType : Codable
    
    // CRUD interface
    func get(request: NSMutableURLRequest, completion: @escaping (Result<SerializedType, Error>) -> Void )
    func post(request: NSMutableURLRequest, completion: @escaping (Result<SerializedType, Error>) -> Void)
    func put(request: NSMutableURLRequest, completion: @escaping (Result<SerializedType, Error>) -> Void)
    func delete(request: NSMutableURLRequest, completion: @escaping (Result<SerializedType, Error>) -> Void)
    
    // Internal workhorse function: implemented in default extension
    func dataTask(request: NSMutableURLRequest, completion: @escaping (Result<SerializedType, Error>) -> Void)
    
    // The implementor needs to implement this to provide the ApiResource that the request needs
    func createURLRequest<T: ApiResourceProviding>(from resource: T) -> NSMutableURLRequest?
}


