Class {
	#name : #TFFIInvokeSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'function',
		'arguments',
		'return'
	],
	#classVars : [
		'Enabled'
	],
	#category : #'Beacon-FFI'
}

{ #category : #accessing }
TFFIInvokeSignal class >> enabled [ 

	^Enabled ifNil: [ false ].
]

{ #category : #accessing }
TFFIInvokeSignal class >> enabled: aBoolean [

	Enabled := aBoolean
]

{ #category : #accessing }
TFFIInvokeSignal >> arguments [
	^ arguments
]

{ #category : #accessing }
TFFIInvokeSignal >> arguments: anObject [
	arguments := anObject
]

{ #category : #'instance creation' }
TFFIInvokeSignal >> emit [ 

	self enabled ifTrue: [ super emit ].
]

{ #category : #accessing }
TFFIInvokeSignal >> enabled [ 

	^Enabled ifNil: [ false ]
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
