# tffi-hack
A hack to make Iceberg work with TFFI

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

Reimplement callback instantiation from an address:
```
(LGitStructWithDefaults allSubclasses, { LGitDiffSimilarityMetric . LGitPackbuilderForeachPayload }) do: [ :eachSubclass |
  eachSubclass methods do: [ :eachMethod | eachSubclass
    compile: (eachMethod sourceCode copyReplaceAll: 'ExternalAddress fromAddress: anObject thunk address' with: 'anObject thunk asExternalAddress')
    classified: eachMethod protocol ] ]
```



