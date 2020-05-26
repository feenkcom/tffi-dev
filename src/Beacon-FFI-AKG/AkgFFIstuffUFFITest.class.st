Class {
	#name : #AkgFFIstuffUFFITest,
	#superclass : #TestCase,
	#category : #'Beacon-FFI-AKG'
}

{ #category : #tests }
AkgFFIstuffUFFITest >> testDoubleCallToCallbacks [
	| callback1 callback2 result |

	callback1 := AkgBlockCallback timesTwo.
	callback2 := AkgShortCallOutCallback shortCallout.
	result := AkgDoubleCallToCallbacks new 
					doubleCallToCallbacks: callback1 
					f2: callback2 
					int: 3.
	self
		assert: result
		equals: 48.
]

{ #category : #tests }
AkgFFIstuffUFFITest >> testShortCallout [

	self
		assert: AkgShortCallOut new shortCallout
		equals: 42.
]

{ #category : #tests }
AkgFFIstuffUFFITest >> testSingleCallToCallback [
	| callback |

	callback := AkgBlockCallback timesTwo.
	self
		assert: (AkgShortCallOut new singleCallToCallback: callback value: 20)
		equals: 42.
]
