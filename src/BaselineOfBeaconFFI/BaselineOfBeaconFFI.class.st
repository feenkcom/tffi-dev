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
				spec repository: 'github://feenkcom/pharo-beacon:a119e739bc378ca2a95883e074090d90fed4edeb/repository' ].
		spec package: 'Beacon-FFI'. ].

]
