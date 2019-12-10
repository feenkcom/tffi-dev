Extension { #name : #GtGleamLoadCallback }

{ #category : #'*GToolkit-Iceberg' }
GtGleamLoadCallback >> calloutAPIClass [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'*GToolkit-Iceberg' }
GtGleamLoadCallback >> ffiLibrary [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ self class ffiLibrary ]
		ifFalse: [ super ffiLibrary ]
]

{ #category : #'*GToolkit-Iceberg' }
GtGleamLoadCallback class >> ffiLibrary [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ GtGleamLibrary ]
		ifFalse: [ super ffiLibraryName ]
]
