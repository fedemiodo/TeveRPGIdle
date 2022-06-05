Class {
	#name : #Hero,
	#superclass : #Object,
	#instVars : [
		'experienceChart',
		'experience',
		'level'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #'instance creation' }
Hero class >> withExperienceChart: anExperienceToLevelChart [ 
	
	^ self new initializeWithExperienceChart: anExperienceToLevelChart
]

{ #category : #leveling }
Hero >> consolidateExperience [

	experienceChart attemptToLevel: self from: level using: experience
]

{ #category : #leveling }
Hero >> earnExperience: anAmount [ 
	
	experience := experience + anAmount
]

{ #category : #initialization }
Hero >> initializeWithExperienceChart: anExperienceToLevelChart [ 
	
	experienceChart := anExperienceToLevelChart.
	experience := 0.
	level := 1
]

{ #category : #stats }
Hero >> level [

	^ level
]

{ #category : #'private - leveling' }
Hero >> levelUp [

	level := level + 1
]

{ #category : #'private - leveling' }
Hero >> levelUpConsuming: requiredExperience [

	experience := experience - requiredExperience.
	self levelUp.
	
	self consolidateExperience
]
