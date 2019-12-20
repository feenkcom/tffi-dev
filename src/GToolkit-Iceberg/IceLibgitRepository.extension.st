Extension { #name : #IceLibgitRepository }

{ #category : #'*GToolkit-Iceberg' }
IceLibgitRepository >> gtActionCommitFor: anAction [
	<gtAction>
	self isMissing ifTrue: [ ^ anAction ].
	^ anAction button
		label: 'Commit...';
		action: [ :aButton | 
			aButton phlow spawnObject: 
				(GtIcebergCommit on: self) ]
]
