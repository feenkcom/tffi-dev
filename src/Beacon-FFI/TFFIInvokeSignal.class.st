Class {
	#name : #TFFIInvokeSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'function',
		'arguments',
		'return'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
TFFIInvokeSignal >> arguments [
	^ arguments
]

{ #category : #accessing }
TFFIInvokeSignal >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
TFFIInvokeSignal >> function [
	^ function
]

{ #category : #accessing }
TFFIInvokeSignal >> function: anObject [
	function := anObject
]

{ #category : #printing }
TFFIInvokeSignal >> printOn: aStream [

	super printOn: aStream.
	aStream cr.
	aStream
		<< 'Function: ';
		<< function address ffiArgumentString;
		cr;
		<< 'Arguments:';
		cr.
	arguments do: [ :each |
		aStream
			<< '    ';
			<< each ffiArgumentString;
			cr. ].
	aStream
		<< 'Return type:';
		cr;
		<< '    ';
		<< return ffiArgumentString.

]

{ #category : #printing }
TFFIInvokeSignal >> printOneLineContentsOn: aStream [

	function printOn: aStream
]

{ #category : #accessing }
TFFIInvokeSignal >> return [
	^ return
]

{ #category : #accessing }
TFFIInvokeSignal >> return: anObject [
	return := anObject
]
