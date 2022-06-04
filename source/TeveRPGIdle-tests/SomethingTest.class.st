Class {
	#name : #SomethingTest,
	#superclass : #TestCase,
	#category : #'TeveRPGIdle-tests'
}

{ #category : #tests }
SomethingTest >> test01HeroIsLevel1WhenCreated [

	| hero |
	hero := Hero new.
	
	self assert: hero level equals: 1
]
