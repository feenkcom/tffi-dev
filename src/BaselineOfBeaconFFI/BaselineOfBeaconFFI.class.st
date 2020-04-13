Class {
	#name : #BaselineOfBeaconFFI,
	#superclass : #BaselineOf,
	#category : #BaselineOfBeaconFFI
}

{ #category : #baseline }
BaselineOfBeaconFFI >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:5d39dadf5d6f039ef6ba24ba8823069925717b84/repository' ].
		spec package: 'Beacon-FFI'. ].

]
