Class {
	#name : #HeroTest,
	#superclass : #TestCase,
	#instVars : [
		'expChart',
		'hero'
	],
	#category : #'TeveRPGIdle-tests'
}

{ #category : #defaults }
HeroTest >> defaultExperienceChart [

	^ ExperienceToLevelChart default
]

{ #category : #'set up' }
HeroTest >> setUp [

	super setUp.
	expChart := self defaultExperienceChart.
	hero := Hero noviceUsing: expChart
]

{ #category : #'tests - experience gain' }
HeroTest >> test01HeroIsLevel1WhenCreated [

	self assert: hero level equals: 1
]

{ #category : #'tests - experience gain' }
HeroTest >> test02HeroWillLevelUpWithEnoughExperience [
	
	self assert: hero level equals: 1.
	
	hero earnExperience: expChart baseExperienceToLevelTo2.
	
	self assert: hero level equals: 1.
	
	hero consolidateExperience.
	
	self assert: hero level equals: 2
]

{ #category : #'tests - experience gain' }
HeroTest >> test03HeroWillLevelUpManyTimesWithEnoughExperience [

	self assert: hero level equals: 1.

	hero earnExperience: expChart baseExperienceToLevelTo3.
	hero consolidateExperience.
	
	self assert: hero level equals: 3
]

{ #category : #'tests - experience gain' }
HeroTest >> test04HeroMayNotHaveEnoughExperienceToLevelUp [
	
	self assert: hero level equals: 1.
	
	hero earnExperience: expChart baseExperienceToLevelTo2 - 1.
	hero consolidateExperience.
	
	self assert: hero level equals: 1
]

{ #category : #'tests - combat' }
HeroTest >> test05HeroCanAttackAUnit [
	
	| dummy |
	
	dummy := Dummy new.
	hero attack: dummy.
	
	self assert: dummy currentHealth equals: 100 - hero attackDamage
]

{ #category : #'tests - experience gain' }
HeroTest >> test05HeroStatsIncreaseUponLevelUp [
	
	self assert: hero level equals: 1.
	self assert: (hero statisticsAreEqualTo: #(2 2 2 1)).
	
	hero earnExperience: expChart baseExperienceToLevelTo2.
	hero consolidateExperience.
	
	self assert: hero level equals: 2.
	self assert: (hero statisticsAreEqualTo: #(3 3 3 1))
]

{ #category : #'tests - combat' }
HeroTest >> test06HeroDamageIncreasesOnLevelUp [
	
	| dummy heroDamage |
	
	dummy := Dummy new.
	heroDamage := hero attackDamage.
	
	self assert: dummy currentHealth equals: 100.
	hero attack: dummy.
	self assert: dummy currentHealth equals: 100 - heroDamage.

	self test02HeroWillLevelUpWithEnoughExperience.
	
	hero attack: dummy.
	self assert: dummy currentHealth < (100 - heroDamage - heroDamage)
]

{ #category : #'tests - combat' }
HeroTest >> test07HeroCanAttackAUnitUntilItDies [
	
	| dummy |
	
	dummy := Dummy new.
	
	[ dummy currentHealth > 0 ] whileTrue: [ hero attack: dummy ].

	self assert: dummy isDead
]

{ #category : #'tests - combat' }
HeroTest >> test08HeroWillEarnExperienceUponDealingAKillingBlow [
	
	| dummy |
	
	dummy := Dummy new.
	
	[ dummy currentHealth > 0 ] whileTrue: [ hero attack: dummy ].
	
	self assert: dummy isDead.
	self assert: hero currentExperience equals: dummy experienceWorth
]

{ #category : #'tests - combat' }
HeroTest >> test11HeroCanReceiveDamageOnAttack [

	| creature |
	creature := Creature satyr.

	creature attack: hero.
	
	self assert: hero currentHealth equals: hero maximumHealth - creature attackDamage
]

{ #category : #'tests - combat' }
HeroTest >> test12HeroMayDieFromDamage [

	| creature |
	creature := Creature iceBear.

	creature attack: hero.
	
	self assert: hero isDead
]
