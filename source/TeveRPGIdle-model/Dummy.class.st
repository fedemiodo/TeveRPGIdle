Class {
	#name : #Dummy,
	#superclass : #Object,
	#instVars : [
		'currentHealth'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #accessing }
Dummy >> currentHealth [

	^ currentHealth
]

{ #category : #'as yet unclassified' }
Dummy >> experienceWorth [

	^ 1
]

{ #category : #initialization }
Dummy >> initialize [

	currentHealth := 100
]

{ #category : #accessing }
Dummy >> isDead [

	^ currentHealth <= 0
]

{ #category : #combat }
Dummy >> receiveDamage: damageTaken from: anAttacker [

	currentHealth := currentHealth - damageTaken.
	
	self isDead ifTrue: [ anAttacker earnExperience: self experienceWorth ]
]
