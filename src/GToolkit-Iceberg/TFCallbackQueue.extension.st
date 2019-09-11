Extension { #name : #TFCallbackQueue }

{ #category : #'*GToolkit-Iceberg' }
TFCallbackQueue class >> shutDown: inANewImageSession [

	ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
		inANewImageSession ifTrue:[
			self uniqueInstance shutDown.
			UniqueInstance := nil. ] ]
]

{ #category : #'*GToolkit-Iceberg' }
TFCallbackQueue class >> startUp: inANewImageSession [

	ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
		inANewImageSession ifTrue:[
			self uniqueInstance startUp. ] ]
]
