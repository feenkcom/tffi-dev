Extension { #name : #GtClipboardLibrary }

{ #category : #'*GToolkit-Iceberg' }
GtClipboardLibrary >> calloutAPIClass [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]

{ #category : #'*GToolkit-Iceberg' }
GtClipboardLibrary >> runner [ 

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFSameThreadRunner new ]
		ifFalse: [ super runner ]

]
