Extension { #name : #ExternalData }

{ #category : #'*Beacon-FFI' }
ExternalData >> ffiArgumentString [
	"Answer a string that makes sense as an argument representation"
	
	^String streamContents: [ :stream |
		stream
			print: self class name;
			nextPutAll: ' @ '; 
			print: self getHandle ].
]
