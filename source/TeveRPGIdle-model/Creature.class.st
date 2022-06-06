Class {
	#name : #Creature,
	#superclass : #Object,
	#instVars : [
		'maximumHealth',
		'attackDamage'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #'instance creation - ice cave' }
Creature class >> iceBear [

	^ self withMaximumHealth: 4500 andAttackDamage: 160
]

{ #category : #'instance creation - starting forest' }
Creature class >> satyr [

	^ self withMaximumHealth: 60 andAttackDamage: 8
]

{ #category : #'private - instance creation' }
Creature class >> withMaximumHealth: anAmountOfHealth andAttackDamage: anAmountOfDamage [

	^ self new initializeWithMaximumHealth: anAmountOfHealth andAttackDamage: anAmountOfDamage
]

{ #category : #combat }
Creature >> attack: aHero [

	aHero receiveAttackFor: self attackDamage
]

{ #category : #accessing }
Creature >> attackDamage [

	^ attackDamage
]

{ #category : #initialization }
Creature >> initializeWithMaximumHealth: anAmountOfHealth andAttackDamage: anAmountOfDamage [

	maximumHealth := anAmountOfHealth.
	attackDamage := anAmountOfDamage
]
