Extension { #name : #ExternalAddress }

{ #category : #'*Beacon-FFI' }
ExternalAddress >> ffiArgumentString [
	"Answer a string that makes sense as an argument representation"
	
	^String streamContents: [ :stream |
		stream
			print: self class name;
			nextPutAll: ' @ '; 
			nextPutAll: (self asInteger storeStringBase: 16 length: 11 padded: true) ].
]
