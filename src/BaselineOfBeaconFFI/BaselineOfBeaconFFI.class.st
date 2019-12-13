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
				spec repository: 'github://feenkcom/pharo-beacon:38cb3436c9593de5abd580b8bb23d06753afdb33/repository' ].
		spec package: 'Beacon-FFI'. ].

]
