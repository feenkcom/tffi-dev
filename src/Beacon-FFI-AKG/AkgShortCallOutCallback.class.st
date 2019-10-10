Class {
	#name : #AkgShortCallOutCallback,
	#superclass : #AkgCallbacks,
	#category : #'Beacon-FFI-AKG'
}

{ #category : #'callback spec' }
AkgShortCallOutCallback class >> fnSpec [

	^#(int #(int a))
]

{ #category : #'instance creation' }
AkgShortCallOutCallback class >> shortCallout [

	^self on: [ :a | a + AkgShortCallOut new shortCallout ]
]
