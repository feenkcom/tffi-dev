Class {
	#name : #TFFIResultSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'function',
		'result'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
TFFIResultSignal >> function [
	^ function
]

{ #category : #accessing }
TFFIResultSignal >> function: anObject [
	function := anObject
]

{ #category : #printing }
TFFIResultSignal >> printOneLineContentsOn: aStream [

	aStream
		print: function;
		<< ': ';
		print: result.
]

{ #category : #accessing }
TFFIResultSignal >> result [
	^ result
]

{ #category : #accessing }
TFFIResultSignal >> result: anObject [
	result := anObject
]
