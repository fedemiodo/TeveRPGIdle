Class {
	#name : #Hero,
	#superclass : #Object,
	#instVars : [
		'experienceChart',
		'experience',
		'level',
		'weaponSlot'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #'instance creation' }
Hero class >> withExperienceChart: anExperienceToLevelChart [ 
	
	^ self new initializeWithExperienceChart: anExperienceToLevelChart
]

{ #category : #itemization }
Hero >> assertFulfillsLevelRequirementsOf: aWeapon [

	^ level >= aWeapon minimumLevel
]

{ #category : #combat }
Hero >> attack: aDummy [

	aDummy receiveDamage: self attackDamage from: self
]

{ #category : #accessing }
Hero >> attackDamage [
	
	| baseDamage levelModifier weaponModifier |
	
	baseDamage := self baseDamage.
	levelModifier := level.
	weaponModifier := weaponSlot damageModifier.
	
	^ baseDamage + levelModifier + weaponModifier
]

{ #category : #accessing }
Hero >> baseDamage [
	
	^ 9
]

{ #category : #leveling }
Hero >> consolidateExperience [

	experienceChart attemptToLevel: self from: level using: experience
]

{ #category : #'private - testing' }
Hero >> currentExperience [

	^ experience
]

{ #category : #leveling }
Hero >> earnExperience: anAmount [ 
	
	experience := experience + anAmount
]

{ #category : #itemization }
Hero >> equip: aWeapon [

	(self assertFulfillsLevelRequirementsOf: aWeapon)
		ifTrue: [ weaponSlot := aWeapon ]
		ifFalse: [ 
			Error signal:
				'Requires level ...(complete with intelligent string).' ]
]

{ #category : #initialization }
Hero >> initializeWithExperienceChart: anExperienceToLevelChart [ 
	
	experienceChart := anExperienceToLevelChart.
	experience := 0.
	level := 1.
	weaponSlot := Weapon unarmed
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
