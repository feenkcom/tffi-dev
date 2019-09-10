Extension { #name : #LGitCallback }

{ #category : #'*GToolkit-Iceberg' }
LGitCallback >> calloutAPIClass [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitCallback class >> ffiLibraryName [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ LGitLibrary ]
		ifFalse: [ super ffiLibraryName ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitCallback >> ffiLibraryName [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ self class ffiLibraryName ]
		ifFalse: [ super ffiLibraryName ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitCallback class >> null [
	^ ExternalAddress null
]
