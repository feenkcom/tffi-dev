Extension { #name : #LGitLibrary }

{ #category : #'*GToolkit-Iceberg' }
LGitLibrary >> calloutAPIClass [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitLibrary >> runner [ 

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFSameThreadRunner new ]
		ifFalse: [ super runner ]

]

{ #category : #'*GToolkit-Iceberg' }
LGitLibrary >> safeCalloutAPIClass [
	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFLGitSafeFFICalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]
