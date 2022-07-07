Class {
	#name : #Item,
	#superclass : #Object,
	#instVars : [
		'statistics'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #equipping }
Item class >> withStatistics: statistics [

	^ self new initializeWithStatistics: statistics
]

{ #category : #initialization }
Item >> initializeWithStatistics: aStatistics [

	statistics := aStatistics
]

{ #category : #accessing }
Item >> statistics [

	^ statistics
]
