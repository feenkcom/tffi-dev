Class {
	#name : #BaselineOfBeaconFFI,
	#superclass : #BaselineOf,
	#category : #BaselineOfBeaconFFI
}

{ #category : #baselines }
BaselineOfBeaconFFI >> baseline: spec [ 
	<baseline>

	spec for: #common do: [ 
		spec
			baseline: 'Beacon'
			with: [ spec repository: 'github://feenkcom/pharo-beacon/repository' ].

		spec 
			package: 'Beacon-FFI';
			group: 'Core' with: #(#Beacon #'Beacon-FFI');
			group: 'all' with: #(#Core);
			group: 'default' with: #(#all).
		 ]
]
