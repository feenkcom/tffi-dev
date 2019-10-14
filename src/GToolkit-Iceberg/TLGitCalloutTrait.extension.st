Extension { #name : #TLGitCalloutTrait }

{ #category : #'*GToolkit-Iceberg' }
TLGitCalloutTrait >> call: fnSpec [
	<ffiCalloutTranslator>
	"^ (self safeFFICalloutIn: thisContext sender)
		cdecl;
		function: fnSpec module: self ffiLibraryName"

	^ (self safeFFICalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: self ffiLibrary uniqueInstance options;
		tffiFunction: fnSpec module: self ffiLibrary uniqueInstance moduleName.
]

{ #category : #'*GToolkit-Iceberg' }
TLGitCalloutTrait >> call: fnSpec options: options [
	<ffiCalloutTranslator>
	"^ (self safeFFICalloutIn: thisContext sender)
		cdecl;
		options: options;
		function: fnSpec module: self ffiLibraryName"

	^ (self safeFFICalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: (self ffiLibrary options), options;
		tffiFunction: fnSpec module: self ffiLibrary uniqueInstance moduleName.
]

{ #category : #'*GToolkit-Iceberg' }
TLGitCalloutTrait >> callUnchecked: fnSpec options: options [
	<ffiCalloutTranslator>
	"^ (self ffiCalloutIn: thisContext sender)
		cdecl;
		options: options;
		function: fnSpec module: self ffiLibraryName"

	^ (self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: (self ffiLibrary options), options;
		tffiFunction: fnSpec module: self ffiLibrary uniqueInstance moduleName.
]
