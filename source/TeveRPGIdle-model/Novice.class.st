Class {
	#name : #Novice,
	#superclass : #Hero,
	#category : #'TeveRPGIdle-model'
}

{ #category : #'instance creation' }
Novice class >> new [

	^ self novice
]

{ #category : #accessing }
Novice >> mainStat [

	^ strength
]
