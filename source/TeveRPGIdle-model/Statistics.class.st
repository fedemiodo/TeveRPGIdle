Class {
	#name : #Statistics,
	#superclass : #Object,
	#instVars : [
		'strength',
		'agility',
		'intelligence',
		'rawDamage'
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

	^ rawDamage
]

{ #category : #initialization }
Statistics >> initializeStrength: str agility: agi intelligence: int damage: dmg [

	strength := str.
	agility := agi.
	intelligence := int.
	rawDamage := dmg
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
Statistics >> modifyIntelligence: aNumber [

	intelligence := intelligence + aNumber
]

{ #category : #private }
Statistics >> modifyRawDamage: aNumber [

	rawDamage := rawDamage + aNumber
]

{ #category : #private }
Statistics >> modifyStrength: aNumber [

	strength := strength + aNumber
]

{ #category : #'stats API' }
Statistics >> modifyWith: aCollection [

	self modifyStrength: aCollection first.
	self modifyAgility: aCollection second.
	self modifyIntelligence: aCollection third.
	self modifyRawDamage: aCollection fourth
]

{ #category : #testing }
Statistics >> statisticsAreEqualTo: aCollection [

	^ ((strength = aCollection first
		and: [ agility =  aCollection second])
			and: [ intelligence = aCollection third ])
				and: [ rawDamage = aCollection fourth ]
]

{ #category : #accessing }
Statistics >> strength [

	^ strength
]
