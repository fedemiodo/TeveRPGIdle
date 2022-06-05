Class {
	#name : #Weapon,
	#superclass : #Object,
	#instVars : [
		'damageModifier',
		'minimumLevel'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #'instance creation' }
Weapon class >> unarmed [

	^ self withDamageModifier: 0
]

{ #category : #'instance creation' }
Weapon class >> withDamageModifier: aDamageModifier [

	^ self  withDamageModifier: aDamageModifier andMinimumLevel: 1
]

{ #category : #'instance creation' }
Weapon class >> withDamageModifier: aDamageModifier andMinimumLevel: aMinLevel [

	^ self new initializeWithDamageModifier: aDamageModifier andMinimumLevel: aMinLevel
]

{ #category : #accessing }
Weapon >> damageModifier [

	^ damageModifier
]

{ #category : #initialization }
Weapon >> initializeWithDamageModifier: aDamageModifier andMinimumLevel: aMinimumLevel [

	damageModifier := aDamageModifier.
	minimumLevel := aMinimumLevel
]

{ #category : #accessing }
Weapon >> minimumLevel [

	^ minimumLevel
]
