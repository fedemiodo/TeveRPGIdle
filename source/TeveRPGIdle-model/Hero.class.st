Class {
	#name : #Hero,
	#superclass : #Object,
	#instVars : [
		'experienceChart',
		'experience',
		'level',
		'currentHealth',
		'maximumHealth',
		'currentEquipment',
		'statistics'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #'instance creation' }
Hero class >> noviceUsing: anExperienceChart [

	^ self using: anExperienceChart withInitialStatistics:
		(Statistics startingFrom: #(2 2 2 1))
]

{ #category : #'private - instance creation' }
Hero class >> using: anExperienceChart withInitialStatistics: aStatistics [

	^ self new initializeUsing: anExperienceChart withInitialStatistics: aStatistics
]

{ #category : #combat }
Hero >> attack: aDummy [

	aDummy receiveAttackFrom: self for: self attackDamage
]

{ #category : #accessing }
Hero >> attackDamage [
	
	^ statistics attackDamage + statistics strength
]

{ #category : #'private - leveling' }
Hero >> canLevelUpConsuming: requiredExperience [

	self levelUpConsuming: requiredExperience.
	self consolidateExperience
]

{ #category : #leveling }
Hero >> consolidateExperience [

	experienceChart attemptToLevel: self from: level using: experience
]

{ #category : #'private - testing' }
Hero >> currentExperience [

	^ experience
]

{ #category : #accessing }
Hero >> currentHealth [

	^ currentHealth
]

{ #category : #leveling }
Hero >> earnExperience: anAmount [ 
	
	experience := experience + anAmount
]

{ #category : #'private - leveling' }
Hero >> increaseStatsDueToLevelUp [

	statistics modifyWith: (Statistics startingFrom: #(1 1 1 0))
]

{ #category : #initialization }
Hero >> initializeEquipment [

	currentEquipment := Array new: 6
]

{ #category : #initialization }
Hero >> initializeExperience [

	experience := 0.
	level := 1
]

{ #category : #initialization }
Hero >> initializeHealth [

	maximumHealth := 20 * statistics strength.
	currentHealth := maximumHealth
]

{ #category : #initialization }
Hero >> initializeUsing: anExperienceChart withInitialStatistics: aStatistics [

	experienceChart := anExperienceChart.
	statistics := aStatistics.
	self initializeExperience.
	self initializeEquipment.
	self initializeHealth
]

{ #category : #death }
Hero >> isDead [

	^ currentHealth < 1
]

{ #category : #accessing }
Hero >> level [

	^ level
]

{ #category : #'private - leveling' }
Hero >> levelUpConsuming: requiredExperience [

	experience := experience - requiredExperience.
	level := level + 1.
	self increaseStatsDueToLevelUp.
]

{ #category : #accessing }
Hero >> maximumHealth [

	^ maximumHealth
]

{ #category : #combat }
Hero >> receiveAttackFor: anAmount [

	currentHealth := currentHealth - anAmount
]

{ #category : #testing }
Hero >> statisticsAreEqualTo: aCollection [

	^ statistics statisticsAreEqualTo: aCollection
]
