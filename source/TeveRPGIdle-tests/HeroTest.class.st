Class {
	#name : #HeroTest,
	#superclass : #TestCase,
	#instVars : [
		'expChart',
		'hero'
	],
	#category : #'TeveRPGIdle-tests'
}

{ #category : #accessing }
HeroTest >> heroWithDefaultExperienceChart [

	^ Hero withExperienceChart: expChart
]

{ #category : #'set up' }
HeroTest >> setUp [

	super setUp.
	expChart := ExperienceToLevelChart default.
	hero := self heroWithDefaultExperienceChart.
]

{ #category : #tests }
HeroTest >> test01HeroIsLevel1WhenCreated [

	self assert: hero level equals: 1
]

{ #category : #tests }
HeroTest >> test02HeroMayLevelUpWithEnoughExperience [
	
	self assert: hero level equals: 1.
	
	hero earnExperience: expChart baseExperienceToLevelTo2.
	
	self assert: hero level equals: 1.
	
	hero consolidateExperience.
	
	self assert: hero level equals: 2
]

{ #category : #tests }
HeroTest >> test03HeroMayLevelUpManyTimesWithEnoughExperience [

	self assert: hero level equals: 1.

	hero earnExperience: expChart baseExperienceToLevelTo3.
	hero consolidateExperience.
	
	self assert: hero level equals: 3
]

{ #category : #tests }
HeroTest >> test04HeroMayNotHaveEnoughExperienceToLevelUp [
	
	self assert: hero level equals: 1.
	
	hero earnExperience: expChart baseExperienceToLevelTo2 - 1.
	hero consolidateExperience.
	
	self assert: hero level equals: 1
]
