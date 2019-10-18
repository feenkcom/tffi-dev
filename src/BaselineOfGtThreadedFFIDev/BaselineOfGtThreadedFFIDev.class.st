Class {
	#name : #BaselineOfGtThreadedFFIDev,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtThreadedFFIDev
}

{ #category : #baselines }
BaselineOfGtThreadedFFIDev >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		"There's temporary logging scattered through during early development.
		The need for Beacon-FFI should be removed eventually."
		spec 
			baseline: #BeaconFFI
			with: [ spec repository: 'github://feenkcom/tffi-dev/src' ].

		spec 
			package: #'GToolkit-Iceberg'
				with: [ spec requires: #(#BeaconFFI) ];
			package: #'FFI-MethodConsistency' ].

]
