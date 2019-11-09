Class {
	#name : #BaselineOfFFIMethodConsistency,
	#superclass : #BaselineOf,
	#category : #BaselineOfFFIMethodConsistency
}

{ #category : #baselines }
BaselineOfFFIMethodConsistency >> baseline: spec [ 
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #'FFI-MethodConsistency' ].

]
