Extension { #name : #GlutinEventCallback }

{ #category : #'*GToolkit-Iceberg' }
GlutinEventCallback >> calloutAPIClass [

	^ ThreadedFFIMigration threadedFFIAvailable
		ifTrue: [ TFCalloutAPI ]
		ifFalse: [ super calloutAPIClass ]
]
