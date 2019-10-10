Extension { #name : #LGitId }

{ #category : #'*Beacon-FFI-AKG' }
LGitId >> ffiArgumentString [
	"Answer a string that makes sense as an argument representation"
	
	^String streamContents: [ :stream |
		stream
			print: self class name;
			nextPutAll: '(<hex id unavailable>)' ].
]
