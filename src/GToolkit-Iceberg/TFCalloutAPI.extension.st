Extension { #name : #TFCalloutAPI }

{ #category : #'*GToolkit-Iceberg' }
TFCalloutAPI class >> newCallbackBackendFor: aCallback [

	^ TFCallback
		forCallback: aCallback
		parameters: (aCallback functionSpec arguments collect: #tfExternalTypeWithArity) asArray
		returnType: aCallback functionSpec returnType tfExternalTypeWithArity
		runner: aCallback ffiLibrary uniqueInstance runner
]
