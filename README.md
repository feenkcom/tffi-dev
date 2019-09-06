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
