Class {
	#name : #Statistics,
	#superclass : #Object,
	#instVars : [
		'strength',
		'agility',
		'intelligence',
		'attackDamage'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #'instance creation' }
Statistics class >> startingFrom: aCollection [

	aCollection size = 4
		ifTrue: [ 
			^ self
				  strength: aCollection first
				  agility: aCollection second
				  intelligence: aCollection third
				  damage: aCollection fourth ]
		ifFalse: [ Error signal: 'Cannot initialize when collection has %1 arguments' ]
]

{ #category : #'instance creation' }
Statistics class >> strength: str agility: agi intelligence: int damage: dmg [

	^ self new initializeStrength: str agility: agi intelligence: int damage: dmg
]

{ #category : #accessing }
Statistics >> agility [

	^ agility
]

{ #category : #accessing }
Statistics >> attackDamage [

	^ attackDamage
]

{ #category : #initialization }
Statistics >> initializeStrength: str agility: agi intelligence: int damage: dmg [

	strength := str.
	agility := agi.
	intelligence := int.
	attackDamage := dmg
]

{ #category : #accessing }
Statistics >> intelligence [

	^ intelligence
]

{ #category : #private }
Statistics >> modifyAgility: aNumber [

	agility := agility + aNumber
]

{ #category : #private }
Statistics >> modifyAttackDamage: aNumber [

	attackDamage := attackDamage + aNumber
]

{ #category : #private }
Statistics >> modifyIntelligence: aNumber [

	intelligence := intelligence + aNumber
]

{ #category : #private }
Statistics >> modifyStrength: aNumber [

	strength := strength + aNumber
]

{ #category : #'stats API' }
Statistics >> modifyWith: anotherStatistics [

	self modifyStrength: anotherStatistics strength.
	self modifyAgility: anotherStatistics agility.
	self modifyIntelligence: anotherStatistics intelligence.
	self modifyAttackDamage: anotherStatistics attackDamage
]

{ #category : #testing }
Statistics >> statisticsAreEqualTo: aCollection [

	^ ((strength = aCollection first
		and: [ agility =  aCollection second])
			and: [ intelligence = aCollection third ])
				and: [ attackDamage = aCollection fourth ]
]

{ #category : #accessing }
Statistics >> strength [

	^ strength
]
