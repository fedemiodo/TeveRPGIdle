Class {
	#name : #ExperienceToLevelChart,
	#superclass : #Object,
	#instVars : [
		'baseExperienceToLevel',
		'multiplier'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #accessing }
ExperienceToLevelChart class >> default [

	^ self withFirstLevelUpAt: 10 andMultiplier: 1.5
]

{ #category : #'instance creation' }
ExperienceToLevelChart class >> withFirstLevelUpAt: experienceToLevel2 andMultiplier: aMultiplier [ 
	
	^ self new withFirstLevelUpAt: experienceToLevel2 andMultiplier: aMultiplier
]

{ #category : #API }
ExperienceToLevelChart >> attemptToLevel: aHero from: aStartingLevel using: anAmountOfExperience [

	| requiredExperience |
	
	requiredExperience := baseExperienceToLevel * (multiplier raisedTo: aStartingLevel - 1).
	
	(anAmountOfExperience >= requiredExperience)
		ifTrue: [ aHero canLevelUpConsuming: requiredExperience ]
]

{ #category : #'private - testing' }
ExperienceToLevelChart >> baseExperienceToLevelTo2 [

	^ baseExperienceToLevel
]

{ #category : #'private - testing' }
ExperienceToLevelChart >> baseExperienceToLevelTo3 [

	^ self baseExperienceToLevelTo2 + (baseExperienceToLevel * multiplier)
]

{ #category : #initialization }
ExperienceToLevelChart >> withFirstLevelUpAt: baseExperience andMultiplier: aMultiplier [ 
	
	baseExperienceToLevel := baseExperience.
	multiplier := aMultiplier
]
