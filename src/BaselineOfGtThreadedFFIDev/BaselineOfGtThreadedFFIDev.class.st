Class {
	#name : #BaselineOfGtThreadedFFIDev,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtThreadedFFIDev
}

{ #category : #baseline }
BaselineOfGtThreadedFFIDev >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: #BeaconFFI with: [
				spec repository: 'github://feenkcom/tffi-dev:v0.6.8/src' ];
			baseline: #ThreadedFFI with: [
				spec repository: 'github://feenkcom/threadedFFI-Plugin:v0.6.4' ].
		spec package: #'GToolkit-Iceberg' with: [
				spec requires: #(#ThreadedFFI #BeaconFFI ). ]. ].

]
