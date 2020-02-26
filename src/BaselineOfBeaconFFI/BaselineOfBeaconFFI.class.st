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
				spec repository: 'github://feenkcom/pharo-beacon:12ccdd418e939ee64d3ebdcfb75c5e3c5a2ce199/repository' ].
		spec package: 'Beacon-FFI'. ].

]
