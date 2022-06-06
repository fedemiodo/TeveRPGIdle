Class {
	#name : #Hero,
	#superclass : #Object,
	#instVars : [
		'experienceChart',
		'experience',
		'level',
		'weaponSlot',
		'strength',
		'agility',
		'intelligence',
		'currentHealth',
		'maximumHealth'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #defaults }
Hero class >> defaultExperienceChart [

	^ ExperienceToLevelChart default
]

{ #category : #'instance creation' }
Hero class >> novice [

	^ Novice strength: 4 agility: 3 intelligence: 3 andExperienceChart: self defaultExperienceChart
]

{ #category : #'private - instance creation' }
Hero class >> strength: anAmountOfStrength agility: anAmountOfAgility intelligence: anAmountOfIntelligence andExperienceChart: anExperienceChart [

	^ super new
		  initializeStrength: anAmountOfStrength
		  agility: anAmountOfAgility
		  intelligence: anAmountOfIntelligence
		  andExperienceChart: anExperienceChart
]

{ #category : #equipment }
Hero >> assertFulfillsLevelRequirementsOf: aWeapon [

	^ level >= aWeapon minimumLevel
]

{ #category : #combat }
Hero >> attack: aDummy [

	aDummy receiveAttackFrom: self for: self attackDamage
]

{ #category : #accessing }
Hero >> attackDamage [
	
	| baseDamage weaponModifier |
	
	baseDamage := self mainStat.
	weaponModifier := weaponSlot damageModifier.
	
	^ baseDamage + weaponModifier
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

{ #category : #equipment }
Hero >> equip: aWeapon [

	(self assertFulfillsLevelRequirementsOf: aWeapon)
		ifTrue: [ weaponSlot := aWeapon ]
		ifFalse: [ 
			Error signal:
				'Requires level ...(complete with intelligent string).' ]
]

{ #category : #'private - leveling' }
Hero >> increaseStatsDueToLevelUp [

	strength := strength + 1
]

{ #category : #initialization }
Hero >> initializeEquipment [

	weaponSlot := Weapon unarmed
]

{ #category : #initialization }
Hero >> initializeExperience [

	experience := 0.
	level := 1
]

{ #category : #initialization }
Hero >> initializeHealth [

	maximumHealth := 20 * strength.
	currentHealth := maximumHealth
]

{ #category : #initialization }
Hero >> initializeStrength: anAmountOfStrength agility: anAmountOfAgility intelligence: anAmountOfIntelligence andExperienceChart: anExperienceChart [

	strength := anAmountOfStrength.
	agility := anAmountOfAgility.
	intelligence := anAmountOfIntelligence.
	experienceChart := anExperienceChart.
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
Hero >> mainStat [
	
	self subclassResponsibility 
]

{ #category : #accessing }
Hero >> maximumHealth [

	^ maximumHealth
]

{ #category : #combat }
Hero >> receiveAttackFor: anAmount [

	currentHealth := currentHealth - anAmount
]
