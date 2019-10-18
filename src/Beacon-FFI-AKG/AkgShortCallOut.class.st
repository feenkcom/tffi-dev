Class {
	#name : #AkgShortCallOut,
	#superclass : #AkgCallouts,
	#category : #'Beacon-FFI-AKG'
}

{ #category : #tests }
AkgShortCallOut >> shortCallout [

	^self
		ffiCall: #(int shortCallout #())
]
