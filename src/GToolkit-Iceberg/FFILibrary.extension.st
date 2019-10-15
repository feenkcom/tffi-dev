Extension { #name : #FFILibrary }

{ #category : #'*GToolkit-Iceberg' }
FFILibrary >> runner [ 

	^ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
		TFSameThreadRunner new
	] ifFalse: [ 
	TFWorker default
	]
]
