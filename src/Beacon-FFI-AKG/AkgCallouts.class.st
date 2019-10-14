Class {
	#name : #AkgCallouts,
	#superclass : #FFIExternalObject,
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

{ #category : #'ffi-calls' }
AkgCallouts >> call: fnSpec options: options [
	<ffiCalloutTranslator>
	"^ (self safeFFICalloutIn: thisContext sender)
		cdecl;
		options: options;
		function: fnSpec module: self ffiLibraryName"

	^ (self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: (self ffiLibrary options), options;
		tffiFunction: fnSpec module: self ffiLibrary uniqueInstance moduleName.
]

{ #category : #resources }
AkgCallouts >> ffiLibrary [

	^self class ffiLibrary
]

{ #category : #resources }
AkgCallouts >> ffiLibraryName [

	^self class ffiLibrary
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
