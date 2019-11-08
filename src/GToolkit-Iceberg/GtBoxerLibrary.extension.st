Extension { #name : #GtBoxerLibrary }

{ #category : #'*GToolkit-Iceberg' }
GtBoxerLibrary >> calloutAPIClass [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'*GToolkit-Iceberg' }
GtBoxerLibrary >> runner [ 

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFSameThreadRunner new ]
		ifFalse: [ super runner ]

]
