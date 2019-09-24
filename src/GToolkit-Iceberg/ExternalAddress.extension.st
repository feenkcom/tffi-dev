Extension { #name : #ExternalAddress }

{ #category : #'*GToolkit-Iceberg' }
ExternalAddress >> address [
	"Answer the receiver's integer address"

	^self asInteger

]

{ #category : #'*GToolkit-Iceberg' }
ExternalAddress >> thunk [ 

	^self
]
