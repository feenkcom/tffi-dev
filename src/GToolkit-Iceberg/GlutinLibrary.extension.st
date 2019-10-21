Extension { #name : #GlutinLibrary }

{ #category : #'*GToolkit-Iceberg' }
GlutinLibrary >> calloutAPIClass [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'*GToolkit-Iceberg' }
GlutinLibrary >> runner [ 

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFSameThreadRunner new ]
		ifFalse: [ super runner ]

]
