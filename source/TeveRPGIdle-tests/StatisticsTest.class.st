Class {
	#name : #StatisticsTest,
	#superclass : #TestCase,
	#category : #'TeveRPGIdle-tests'
}

{ #category : #tests }
StatisticsTest >> test01ItemWithOnlyOneStatistic [

	| item sheet |
	
	item := Item withStatistics:
		(Statistics
			strength: 0 agility: 0 intelligence: 0 damage: 2).
	
	self assert: (item statisticsAreEqualTo: #(0 0 0 2))
]
