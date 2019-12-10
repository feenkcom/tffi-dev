Extension { #name : #GtGleamLibrary }

{ #category : #'*GToolkit-Iceberg' }
GtGleamLibrary >> calloutAPIClass [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'*GToolkit-Iceberg' }
GtGleamLibrary >> runner [ 

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFSameThreadRunner uniqueInstance ]
		ifFalse: [ super runner ]

]
