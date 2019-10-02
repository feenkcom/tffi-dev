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
			package: 'Beacon-FFI';
			group: 'Core' with: #(#'Beacon-FFI');
			group: 'all' with: #(#Core);
			group: 'default' with: #(#all).
		 ]
]
