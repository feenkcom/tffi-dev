# tffi-dev

Temporary repository while we get Pharo 8 working with Threaded FFI.

## Load TFFI in Pharo8 with headless vm
````
EpMonitor current disable.
[ 
	Metacello new
		baseline: 'ThreadedFFI';
		repository: 'github://pharo-project/threadedFFI-Plugin/src';
		load
] ensure: [ EpMonitor current enable ].
````

## Implement

```
LGitCallback >> calloutAPIClass
	^ TFCalloutAPI
```

```
LGitCallback >> ffiLibraryName
	^ self class ffiLibraryName
```

```
LGitCallback class >> null
	^ ExternalAddress null
```

```
LGitCallback class >> ffiLibraryName
	^ LGitLibrary
```

```
LGitLibrary >> calloutAPIClass
	^ TFCalloutAPI
```

```
LGitLibrary >> runner 
	^ TFSameThreadRunner new
```

```
ExternalAddress >> asExternalAddress
	^ self
```

```
ExternalAddress >> thunk
	^ self
```

```
TLGitCalloutTrait >> call: fnSpec
	<ffiCalloutTranslator>
	
	^ (self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: self ffiLibrary uniqueInstance options;
		function: fnSpec module: self ffiLibrary uniqueInstance moduleName
```

```
TLGitCalloutTrait >> call: fnSpec options: options
	<ffiCalloutTranslator>
	
	^ (self ffiCalloutIn: thisContext sender)
		convention: self ffiCallingConvention;
		options: (self ffiLibrary options), options;
		function: fnSpec module: self ffiLibrary uniqueInstance moduleName
```


Reimplement callback instantiation from an address:
```
(LGitStructWithDefaults allSubclasses, { LGitDiffSimilarityMetric . LGitPackbuilderForeachPayload }) do: [ :eachSubclass |
  eachSubclass methods do: [ :eachMethod | eachSubclass
    compile: (eachMethod sourceCode copyReplaceAll: 'ExternalAddress fromAddress: anObject thunk address' with: 'anObject thunk asExternalAddress')
    classified: eachMethod protocol ] ]
```

Returning a structure by pointer does not work, so we have to redefine all such cases as `void *`

```
LGitCommit >> commit_author: commit
	
	^ self
		call: #(void * git_commit_author #(self))
		options: #()
```

```

LGitId >> hexString
	| string |
	self isExternal
		ifFalse: [ ^ handle hex ].
	string := ByteArray new: 40.
	string pin.
	self oid_fmt: string id: self.
	string unpin.
	^ string asString
```
