Class {
	#name : #FFIInvokeSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'function',
		'arguments'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
FFIInvokeSignal >> arguments [
	^ arguments
]

{ #category : #accessing }
FFIInvokeSignal >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
FFIInvokeSignal >> function [
	^ function
]

{ #category : #accessing }
FFIInvokeSignal >> function: anObject [
	function := anObject
]

{ #category : #printing }
FFIInvokeSignal >> printOn: aStream [

	aStream
		nextPut:$<;
		nextPutAll: function callingConventionString; nextPutAll:': '.
	{ 'threaded' } with: { function class callingConventionModifierFor: 'threaded' } do:
		[:modifier :flag|
		(function flags anyMask: flag) ifTrue:
			[aStream nextPutAll: modifier; space]].
	aStream print: function argTypes first; space.
	self name == nil
		ifTrue:[aStream nextPutAll:'(*) ']
		ifFalse:[aStream << function name asString; space].
	aStream nextPut:$(.
	2 to: function argTypes size do:[:i|
		aStream print: (function argTypes at: i).
		i < function argTypes size ifTrue:[aStream space]].
	aStream nextPut: $).
	aStream cr.
	arguments do: [ :each |
		aStream
			<< '    ';
			<< each ffiArgumentString;
			cr. ]
]

{ #category : #printing }
FFIInvokeSignal >> printOneLineContentsOn: aStream [
	"hook to be overriden by subclasses"

	aStream
		nextPut:$<;
		nextPutAll: function callingConventionString; nextPutAll:': '.
	{ 'threaded' } with: { function class callingConventionModifierFor: 'threaded' } do:
		[:modifier :flag|
		(function flags anyMask: flag) ifTrue:
			[aStream nextPutAll: modifier; space]].
	aStream print: function argTypes first; space.
	self name == nil
		ifTrue:[aStream nextPutAll:'(*) ']
		ifFalse:[aStream << function name asString; space].
	aStream nextPut:$(.
	2 to: function argTypes size do:[:i|
		aStream print: (function argTypes at: i).
		i < function argTypes size ifTrue:[aStream space]].
	aStream nextPut: $).
]
