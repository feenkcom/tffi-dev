Class {
	#name : #FFIResultSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'function',
		'result'
	],
	#classVars : [
		'Enabled'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
FFIResultSignal >> function [
	^ function
]

{ #category : #accessing }
FFIResultSignal >> function: anObject [
	function := anObject
]

{ #category : #printing }
FFIResultSignal >> printOneLineContentsOn: aStream [
	"hook to be overriden by subclasses"

	aStream
		print: function;
		<< ': ';
		print: result.
]

{ #category : #accessing }
FFIResultSignal >> result [
	^ result
]

{ #category : #accessing }
FFIResultSignal >> result: anObject [
	result := anObject
]
