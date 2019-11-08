Extension { #name : #GlutinEventCallback }

{ #category : #'*GToolkit-Iceberg' }
GlutinEventCallback >> calloutAPIClass [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'*GToolkit-Iceberg' }
GlutinEventCallback >> ffiLibrary [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ self class ffiLibrary ]
		ifFalse: [ super ffiLibrary ]
]

{ #category : #'*GToolkit-Iceberg' }
GlutinEventCallback class >> ffiLibrary [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ GlutinLibrary ]
		ifFalse: [ super ffiLibraryName ]
]
