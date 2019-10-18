Extension { #name : #TLGitCalloutTrait }

{ #category : #'*GToolkit-Iceberg' }
TLGitCalloutTrait >> call: fnSpec [
	<ffiCalloutTranslator>
	"^ (self safeFFICalloutIn: thisContext sender)
		cdecl;
		function: fnSpec module: self ffiLibraryName"

	| ffiLibrary |
	ffiLibrary := self ffiLibrary asFFILibrary.
	^ (ffiLibrary safeCalloutAPIClass inUFFIContext: thisContext)
		convention: self ffiCallingConvention;
		options: self ffiLibrary uniqueInstance options;
		function: fnSpec library: ffiLibrary.
]

{ #category : #'*GToolkit-Iceberg' }
TLGitCalloutTrait >> call: fnSpec options: options [
	<ffiCalloutTranslator>
	"^ (self safeFFICalloutIn: thisContext sender)
		cdecl;
		options: options;
		function: fnSpec module: self ffiLibraryName"

	| ffiLibrary |
	ffiLibrary := self ffiLibrary asFFILibrary.
	^ (ffiLibrary safeCalloutAPIClass inUFFIContext: thisContext)
		convention: self ffiCallingConvention;
		options: (self ffiLibrary uniqueInstance options), options;
		function: fnSpec library: ffiLibrary.

]

{ #category : #'*GToolkit-Iceberg' }
TLGitCalloutTrait >> callUnchecked: fnSpec options: options [
	<ffiCalloutTranslator>
	"^ (self ffiCalloutIn: thisContext sender)
		cdecl;
		options: options;
		function: fnSpec module: self ffiLibraryName"

	| ffiLibrary |
	ffiLibrary := self ffiLibrary asFFILibrary.
	^ (ffiLibrary calloutAPIClass inUFFIContext: thisContext)
		convention: self ffiCallingConvention;
		options: (self ffiLibrary uniqueInstance options), options;
		function: fnSpec library: ffiLibrary.

]
