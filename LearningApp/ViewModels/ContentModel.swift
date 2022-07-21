//
//  ContentModel.swift
//  LearningApp
//
//  Created by Andy on 7/20/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    @Published var currentModule:Module?
    var currentModuleIndex = 0
    
    
    var styleData:Data?
    
    init() {
        getLocalData()
    }
    
    //MARK: Data Methods
    
    func getLocalData() {
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let decoder = JSONDecoder()
            
            do {
                
                let modules = try decoder.decode([Module].self, from: jsonData)
                self.modules = modules
                
            } catch {
                print("Error decoding json file.")
            }
                
            
        } catch {
            print("Error fetching data from json.")
        }
        
        let styleUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
             
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
            
        } catch {
            print("Couldn't parse style data")
        }
    }
    
    //MARK: Module Navigation Methods
    
    func beginModule(_ moduleid:Int) {
        
        // find the index for module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                currentModuleIndex = index
                break
            }
        }
        
        // set current module
        currentModule = modules[currentModuleIndex]
    }
}
