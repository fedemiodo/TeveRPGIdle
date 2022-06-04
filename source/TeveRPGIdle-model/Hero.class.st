Class {
	#name : #Hero,
	#superclass : #Object,
	#instVars : [
		'level'
	],
	#category : #'TeveRPGIdle-model'
}

{ #category : #stats }
Hero >> initialize [

	level := 1
]

{ #category : #stats }
Hero >> level [

	^ level
]
