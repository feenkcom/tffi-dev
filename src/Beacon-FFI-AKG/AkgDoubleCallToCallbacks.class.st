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
	FFICallbackSignal enabled: true.
	TFFIInvokeSignal enabled: true.
	TFFIResultSignal enabled: true.
	TFFICallbackSignal enabled: true.
	result := self new 
		doubleCallToCallbacks: AkgBlockCallback timesTwo 
		f2: AkgShortCallOutCallback shortCallout 
		int: 7.
	FFIInvokeSignal enabled: false.
	FFIResultSignal enabled: false.
	FFICallbackSignal enabled: false.
	TFFIInvokeSignal enabled: false.
	TFFIResultSignal enabled: false.
	TFFICallbackSignal enabled: false.
	self assert: result = 56.
	^result.
]

{ #category : #'ffi calls' }
AkgDoubleCallToCallbacks >> doubleCallToCallbacks: fun1 f2: fun2 int: integer [

	^self
		ffiCall: #(int doubleCallToCallbacks #(FFICallback fun1, FFICallback fun2, int integer))
]
