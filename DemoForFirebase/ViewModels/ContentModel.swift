//
//  ContentModel.swift
//  DemoForFirebase
//
//  Created by Alexis Willey on 12/7/21.
//

import Foundation


class ContentModel: ObservableObject {
    
    //Whatever view code is using this published object it will update accordingly
    @Published var modules = [Module]()
    
    //Current Module, any UI referencing currentModule will update automatically
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    
    //Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data Methods
    
    func getLocalData() {
        
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        // Read file into a data object
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            self.modules = modules
        } catch {
            
            //TODO log error
            print("Couldn't parse local data")
            
        }
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            //Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
            
        } catch {
            // Log error
            print("Couldn't parse style data")
        }
        
    }
    
    // MARK: - MOdule navigation methods
    
    func beginModule(_ moduleid:Int) {
        
        // Find the index for the module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                // Found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex: Int ) {
        
        //Check that the lesson index is within range of module lesson
        if lessonIndex < currentModule!.content.lessons.count{
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
    }
    
    func nextLesson() {
        
        // Advance the lesson index
        currentLessonIndex += 1
        
        
        // Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        }
        else {
            // Rset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        
        }
        
    }
    
    func hasNextLesson() -> Bool {
        
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            
            return true
        }
        else {
            return false
        }
    }
    
}
