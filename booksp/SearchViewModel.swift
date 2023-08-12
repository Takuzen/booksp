//
//  SearchViewModel.swift
//  booksp
//
//  Created by Takuzen Toh on 8/12/23.
//

import SwiftUI
import RealityKit
import Observation
import Foundation

class SearchViewModel {
    
    private var contentEntity = Entity()
    private var boardPlanes: [ModelEntity] = []
    private var images: [MaterialParameters.Texture] = []
    
    func setupContentEntity() -> Entity {
        
        for i in 1..<26 {
            let name = "laputa\(String(format: "%03d", i))"
            if let texture = try? TextureResource.load(named: name) {
                images.append(MaterialParameters.Texture(texture))
            }
        }
        
        setup()
        return contentEntity
    }
    
    // MARK: - Private
    
    private func setup() {
        
        for i in 0..<3 {
            let boardPlane = ModelEntity(
                mesh: .generatePlane(width: 3, height: 2),
                materials: [SimpleMaterial(color: .clear, isMetallic: false)]
            )
            
            boardPlane.position = SIMD3<Float>(x: 0, y: 2, z: -0.5 - 0.1 * Float(i + 1))
            
            contentEntity.addChild(boardPlane)
            boardPlanes.append(boardPlane)
            
            addChildEntities(boardPlane: boardPlane)
        }
    }
    
    private func addChildEntities(boardPlane: ModelEntity) {
        
        var i: Int = 0
        
        for image in images.shuffled().prefix(30) {
            
            let divisionResult = i.quotientAndRemainder(dividingBy: 5)
            
            let x: Float = Float(divisionResult.remainder) * 0.4 - 0.75
            let y: Float = Float(divisionResult.quotient) * 0.25 - 0.5
            let z: Float = boardPlane.position.z + Float(i) * 0.0001
            
            let entity = makePlane(name: "", posision: SIMD3<Float>(x: x, y: y, z: z), texture: image)
            
            boardPlane.addChild(entity)
            
            i += 1
        }
    }
    
    private func makePlane(name: String, posision: SIMD3<Float>, texture: MaterialParameters.Texture) -> ModelEntity {
        
        var material = SimpleMaterial()
        material.color = .init(texture: texture)
        
        let entity = ModelEntity(
            mesh: .generatePlane(width: 0.32, height: 0.18, cornerRadius: 0.0),
            materials: [material],
            collisionShape: .generateBox(width: 0.32, height: 0.18, depth: 0.1),
            mass: 0.0
        )
        
        entity.name = name
        entity.position = posision
        entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
        
        return entity
    }
}
