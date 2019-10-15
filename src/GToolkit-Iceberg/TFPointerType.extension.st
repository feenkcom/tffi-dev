Extension { #name : #TFPointerType }

{ #category : #'*GToolkit-Iceberg' }
TFPointerType >> printOn: aStream [

	aStream << 'void *'
]

{ #category : #'*GToolkit-Iceberg' }
TFPointerType >> write: anExternalAddress into: targetAddress [

	| address bytes |

	(anExternalAddress isKindOf: Bitmap) ifTrue: [  
		anExternalAddress pinInMemory.
		address := PointerUtils oopForObject: anExternalAddress.
		targetAddress pointerAt: 1 put: address.
		^ self.
	].

	(anExternalAddress isKindOf: String) ifTrue: [ 
		bytes := anExternalAddress utf8Encoded.
		bytes pinInMemory.
		address := PointerUtils oopForObject: bytes.
		targetAddress pointerAt: 1 put: address.
		^self ].

	(anExternalAddress isKindOf: ByteArray)
		ifTrue: [ address := anExternalAddress ]
		ifFalse: [ anExternalAddress
				ifNil: [ address := ExternalAddress null ]
				ifNotNil: [ (anExternalAddress isKindOf: ExternalAddress)
						ifTrue: [ address := anExternalAddress ]
						ifFalse: [ address := anExternalAddress getHandle ] ] ].

	address isExternalAddress
		ifFalse: [ address pinInMemory.
			address := PointerUtils oopForObject: address ].

	targetAddress pointerAt: 1 put: address
]
