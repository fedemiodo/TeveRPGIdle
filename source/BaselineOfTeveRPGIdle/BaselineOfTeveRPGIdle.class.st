Class {
	#name : #BaselineOfTeveRPGIdle,
	#superclass : #BaselineOf,
	#category : #BaselineOfTeveRPGIdle
}

{ #category : #baselines }
BaselineOfTeveRPGIdle >> baseline: spec [

	<baseline>
	self setUpDependencies: spec.
	self setUpPackages: spec
]

{ #category : #baselines }
BaselineOfTeveRPGIdle >> projectClass [

    ^ MetacelloCypressBaselineProject
]

{ #category : #baselines }
BaselineOfTeveRPGIdle >> setUpDependencies: spec [

	spec baseline: 'Aconcagua' with: [ spec repository: 'github://ba-st/Aconcagua:v8/source' ].
	spec baseline: 'Chalten' with: [ spec repository: 'github://ba-st/Chalten:v8/source' ].
	spec baseline: 'Buoy' with: [ spec repository: 'github://ba-st/Buoy:v6/source' ].
]

{ #category : #baselines }
BaselineOfTeveRPGIdle >> setUpPackages: spec [

	spec for: #pharo do: [ 
		spec
			package: 'TeveRPGIdle-model' with: [ spec requires: #('Buoy' 'Aconcagua' 'Chalten') ];
			package: 'TeveRPGIdle-tests' with: [ spec requires: #('TeveRPGIdle-model') ].
		spec
			group: 'Tests' with: 'TeveRPGIdle-tests';
			group: 'Development' with: 'Tests'
		 ]
]
