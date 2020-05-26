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

{ #category : #tests }
AkgShortCallOut >> singleCallToCallback: callback value: value [

	^ self ffiCall: #(int singleCallToCallback(void* callback, int value))
]
