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
				spec repository: 'github://feenkcom/pharo-beacon:6dc8bb30429f355574f82a52b9fa33b465cab7f4/repository' ].
		spec package: 'Beacon-FFI'. ].

]
