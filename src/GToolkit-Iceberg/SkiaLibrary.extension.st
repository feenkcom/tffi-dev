Extension { #name : #SkiaLibrary }

{ #category : #'*GToolkit-Iceberg' }
SkiaLibrary >> calloutAPIClass [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'*GToolkit-Iceberg' }
SkiaLibrary >> runner [ 

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFSameThreadRunner uniqueInstance ]
		ifFalse: [ super runner ]

]
