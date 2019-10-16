Class {
	#name : #AkgDoubleCallToCallbacks,
	#superclass : #AkgCallouts,
	#category : #'Beacon-FFI-AKG'
}

{ #category : #convenience }
AkgDoubleCallToCallbacks class >> logDoubleCallback [
	<gtExample>
	<script>

	| result |

	FFIInvokeSignal enabled: true.
	FFIResultSignal enabled: true.
	TFFIInvokeSignal enabled: true.
	TFFIResultSignal enabled: true.
	result := self new 
		doubleCallToCallbacks: AkgBlockCallback timesTwo 
		f2: AkgShortCallOutCallback shortCallout 
		int: 7.
	FFIInvokeSignal enabled: false.
	FFIResultSignal enabled: false.
	TFFIInvokeSignal enabled: false.
	TFFIResultSignal enabled: false.
	self assert: result = 56.
	^result
]

{ #category : #'ffi calls' }
AkgDoubleCallToCallbacks >> doubleCallToCallbacks: fun1 f2: fun2 int: integer [

	^self
		ffiCall: #(int doubleCallToCallbacks #(void * fun1, void * fun2, int integer))
]
