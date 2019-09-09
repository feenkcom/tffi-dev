Class {
	#name : #BaselineOfGtThreadedFFIDev,
	#superclass : #BaselineOf,
	#category : #BaselineOfGtThreadedFFIDev
}

{ #category : #baselines }
BaselineOfGtThreadedFFIDev >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #'GToolkit-Iceberg' ].

]
