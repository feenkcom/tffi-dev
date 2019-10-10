Extension { #name : #ByteArray }

{ #category : #'*Beacon-FFI' }
ByteArray >> ffiArgumentString [
	"Answer a string that makes sense as an argument representation"
	
	^String streamContents: [ :stream | | pinned |
		pinned := self pinInMemory.
		stream
			print: self class name;
			<< '[';
			print: self size;
			<< '] @ ';
			print: (PointerUtils primOopForObject: self).
		pinned ifFalse: [ self unpinInMemory ] ].
]
