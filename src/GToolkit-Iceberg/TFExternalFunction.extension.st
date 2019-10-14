Extension { #name : #TFExternalFunction }

{ #category : #'*GToolkit-Iceberg' }
TFExternalFunction >> printOn: aStream [

	functionName ifNil: [ ^super printOn: aStream ].
	aStream
		<< functionName;
		print: definition.
]
