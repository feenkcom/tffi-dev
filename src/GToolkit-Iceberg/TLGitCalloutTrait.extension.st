Extension { #name : #TLGitCalloutTrait }

{ #category : #'*GToolkit-Iceberg' }
TLGitCalloutTrait >> call: fnSpec [
	<ffiCalloutTranslator>
	
	^ (self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: self ffiLibrary uniqueInstance options;
		function: fnSpec module: self ffiLibrary uniqueInstance moduleName
]

{ #category : #'*GToolkit-Iceberg' }
TLGitCalloutTrait >> call: fnSpec options: options [
	<ffiCalloutTranslator>
	
	^ (self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: (self ffiLibrary options), options;
		function: fnSpec module: self ffiLibrary uniqueInstance moduleName
]
