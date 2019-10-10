Class {
	#name : #AkgCallouts,
	#superclass : #FFIExternalObject,
	#traits : 'TLGitCalloutTrait',
	#classTraits : 'TLGitCalloutTrait classTrait',
	#category : #'Beacon-FFI-AKG'
}

{ #category : #resources }
AkgCallouts class >> ffiLibrary [ 

	^AkgLibTestLibrary
]

{ #category : #resources }
AkgCallouts class >> ffiLibraryName [

	^'libTestLibrary.so'
]

{ #category : #'initialize-release' }
AkgCallouts >> free [
	handle isExternalAddress 
		ifTrue: [ 
			self class finalizeResourceData: handle.
			self assert: handle isNull ]
]

{ #category : #initialization }
AkgCallouts >> initialize [
	super initialize.
	self autoRelease.
]
