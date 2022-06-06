Class {
	#name : #HeroTest,
	#superclass : #TestCase,
	#instVars : [
		'expChart',
		'hero'
	],
	#category : #'TeveRPGIdle-tests'
}

{ #category : #'set up' }
HeroTest >> setUp [

	super setUp.
	hero := Novice new.
	expChart := Hero defaultExperienceChart
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
	
	self assert: dummy currentHealth equals: 100 - hero attackDamage
]

{ #category : #tests }
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

{ #category : #tests }
HeroTest >> test07HeroCanAttackAUnitUntilItDies [
	
	| dummy |
	
	dummy := Dummy new.
	
	[ dummy currentHealth > 0 ] whileTrue: [ hero attack: dummy ].

	self assert: dummy isDead
]

{ #category : #tests }
HeroTest >> test08HeroWillEarnExperienceUponDealingAKillingBlow [
	
	| dummy |
	
	dummy := Dummy new.
	
	[ dummy currentHealth > 0 ] whileTrue: [ hero attack: dummy ].
	
	self assert: dummy isDead.
	self assert: hero currentExperience equals: dummy experienceWorth
]

{ #category : #tests }
HeroTest >> test09HeroCanEquipAnItemAndGainItsStats [
	
	| weapon |
	
	weapon := Weapon withDamageModifier: 1.
	
	self assert: hero attackDamage equals: 4.
	hero equip: weapon.
	self assert: hero attackDamage equals: 5
]

{ #category : #tests }
HeroTest >> test10HeroCannotEquipWeaponWithHigherLevelRequirement [

	| weapon |
	weapon := Weapon withDamageModifier: 1 andMinimumLevel: 2.

	self assert: hero attackDamage equals: 4.

	self
		should: [ hero equip: weapon ]
		raise: Error
		withExceptionDo: [ :error | 
			self assert: hero attackDamage equals: 4 ]
]

{ #category : #tests }
HeroTest >> test11HeroCanReceiveDamageOnAttack [

	| creature |
	creature := Creature satyr.

	creature attack: hero.
	
	self assert: hero currentHealth equals: hero maximumHealth - creature attackDamage
]

{ #category : #tests }
HeroTest >> test12HeroMayDieFromDamage [

	| creature |
	creature := Creature iceBear.

	creature attack: hero.
	
	self assert: hero isDead
]
