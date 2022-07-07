Class {
	#name : #StatisticsTest,
	#superclass : #TestCase,
	#category : #'TeveRPGIdle-tests'
}

{ #category : #asserting }
StatisticsTest >> assertStatisticsOf: item areEqualTo: aCollection [
	
	| rawStats |
	
	rawStats := Statistics startingFrom: #(0 0 0 0).
	
	rawStats modifyWith: item statistics.
	
	self
		assert: rawStats strength equals: aCollection first;
		assert: rawStats agility equals: aCollection second;
		assert: rawStats intelligence equals: aCollection third;
		assert: rawStats attackDamage equals: aCollection fourth
]

{ #category : #tests }
StatisticsTest >> test01ItemWithOnlyOneStatistic [

	| item |
	
	item := Item withStatistics:
		(Statistics
			strength: 0 agility: 0 intelligence: 0 damage: 2).
	
	self assertStatisticsOf: item areEqualTo: #(0 0 0 2)
]
