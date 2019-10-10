Class {
	#name : #AkgDoubleCallToCallbacks,
	#superclass : #AkgCallouts,
	#category : #'Beacon-FFI-AKG'
}

{ #category : #'ffi calls' }
AkgDoubleCallToCallbacks >> doubleCallToCallbacks: fun1 f2: fun2 int: integer [

	^self
		call: #(int doubleCallToCallbacks #(void * fun1, void * fun2, int integer))
		options: #()
]
