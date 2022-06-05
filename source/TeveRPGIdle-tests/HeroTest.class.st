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
HeroTest >> test02HeroWillLevelUpWithEnoughExperience [
	
	self assert: hero level equals: 1.
	
	hero earnExperience: expChart baseExperienceToLevelTo2.
	
	self assert: hero level equals: 1.
	
	hero consolidateExperience.
	
	self assert: hero level equals: 2
]

{ #category : #tests }
HeroTest >> test03HeroWillLevelUpManyTimesWithEnoughExperience [

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

{ #category : #tests }
HeroTest >> test05HeroCanAttackAUnit [
	
	| dummy |
	
	dummy := Dummy new.
	hero attack: dummy.
	
	self assert: dummy currentHealth equals: 90
]

{ #category : #tests }
HeroTest >> test06HeroDamageIncreasesOnLevelUp [
	
	| dummy |
	
	dummy := Dummy new.
	
	self assert: dummy currentHealth equals: 100.
	hero attack: dummy.
	self assert: dummy currentHealth equals: 90.

	self test02HeroWillLevelUpWithEnoughExperience.
	
	hero attack: dummy.
	self assert: dummy currentHealth equals: 79
]

{ #category : #tests }
HeroTest >> test07HeroCanAttackAUnitUntilItDies [
	
	| dummy |
	
	dummy := Dummy new.
	
	10 timesRepeat: [ hero attack: dummy ].
	
	self assert: dummy currentHealth equals: 0.
	self assert: dummy isDead
]

{ #category : #tests }
HeroTest >> test08HeroWillEarnExperienceUponDealingAKillingBlow [
	
	| dummy |
	
	dummy := Dummy new.
	
	10 timesRepeat: [ hero attack: dummy ].
	
	self assert: dummy currentHealth equals: 0.
	self assert: dummy isDead.
	
	self assert: hero currentExperience equals: dummy experienceWorth
]

{ #category : #tests }
HeroTest >> test09HeroCanEquipAnItemAndGainItsStats [
	
	| weapon |
	
	weapon := Weapon withDamageModifier: 1.
	
	self assert: hero attackDamage equals: 10.
	hero equip: weapon.
	self assert: hero attackDamage equals: 11
]

{ #category : #tests }
HeroTest >> test10HeroCannotEquipWeaponWithHigherLevelRequirement [

	| weapon |
	weapon := Weapon withDamageModifier: 1 andMinimumLevel: 2.

	self assert: hero attackDamage equals: 10.

	self
		should: [ hero equip: weapon ]
		raise: Error
		withExceptionDo: [ :error | 
			self assert: hero attackDamage equals: 10 ]
]
