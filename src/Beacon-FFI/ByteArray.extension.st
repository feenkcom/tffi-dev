Extension { #name : #ByteArray }

{ #category : #'*Beacon-FFI' }
ByteArray >> ffiArgumentString [
	"Answer a string that makes sense as an argument representation"
	
	^ self class environment
		at: #ThreadedFFIMigration
		ifPresent: [ :aThreadedFFIMigration |
			aThreadedFFIMigration threadedFFIAvailable
				ifTrue: [
					String streamContents: [ :stream | | pinned |
						pinned := self pinInMemory.
						stream
							print: self class name;
							<< '[';
							print: self size;
							<< '] @ ';
							print: (PointerUtils primOopForObject: self).
						pinned ifFalse: [ self unpinInMemory ] ] ]
				ifFalse: [ self printString ] ]
		ifAbsent: [ self printString ]
]
