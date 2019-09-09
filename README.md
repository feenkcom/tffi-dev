# tffi-dev

Temporary repository while we get Pharo 8 working with Threaded FFI.

## Load in Pharo8 with headless vm

The latest version may be retrieved with zeroconf:

```
curl get.pharo.org/64/80+vmHeadlessLatest | bash
```

Since `tffi-dev` over-writes methods in the core repositories it is worthwhile having access to the history there:

`TBC`

Load Threaded FFI and then the Iceberg extensions:

```
EpMonitor current disable.
[ 
	Metacello new
		baseline: 'ThreadedFFI';
		repository: 'github://pharo-project/threadedFFI-Plugin/src';
		load

	Metacello new
		baseline: 'GtThreadedFFIDev';
		repository: 'github://feenkcom/tffi-dev/src';
		load.

] ensure: [ EpMonitor current enable ].
```


# Obsolete Notes

Reimplement callback instantiation from an address:

```
(LGitStructWithDefaults allSubclasses, { LGitDiffSimilarityMetric . LGitPackbuilderForeachPayload }) do: [ :eachSubclass |
  eachSubclass methods do: [ :eachMethod | eachSubclass
    compile: (eachMethod sourceCode copyReplaceAll: 'ExternalAddress fromAddress: anObject thunk address' with: 'anObject thunk asExternalAddress')
    classified: eachMethod protocol ] ]
```
