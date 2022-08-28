//
//  Models.swift
//  Learning-App
//
//  Created by Prisha Anand on 8/28/22.
//

import Foundation

struct Module: Identifiable, Decodable {
    
    var id: Int
    var category: String
    var content: Content
    var test: Test
    
}

struct Content: Identifiable, Decodable {
    
    var id: Int
    var image: String
    var time: String
    var description: String
    var lessons: [Lesson]
    
}

struct Lesson: Identifiable, Decodable {
    
    var id: Int
    var title: String
    var video: String
    var duration: String
    var explanation: String
    
}

struct Test: Identifiable, Decodable {
    
    var id: Int
    var image: String
    var time: String
    var description: String
    var questions: [Question]
    
}

struct Question: Identifiable, Decodable {
    
    var id: Int
    var content: String
    var correctIndex: Int
    var answers: [String]
    
}
