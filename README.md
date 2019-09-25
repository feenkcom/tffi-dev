# tffi-dev

Temporary repository while we get Pharo 8 working with Threaded FFI.

## Load in Pharo8 with headless vm

The latest version may be retrieved with zeroconf:

```
curl get.pharo.org/64/80+vmHeadlessLatest | bash
```

Start Pharo in the normal manner:

```
./pharo-ui Pharo.image
```


Since `tffi-dev` over-writes methods in the core repositories it is worthwhile having access to the history there:

```
| iceRep repository remoteUrl location subdirectory userName projectName githubRepository remote |

"If you have a private fork of the pharo repository, set your username below (as a String) and it will be added as a remote"
userName := nil.
projectName := 'pharo'.

repository := IceRepository registry detect: [ :each | each name = 'pharo' ].
remoteUrl := 'git@github.com:pharo-project/pharo.git'.
location := (FileLocator imageDirectory / 'pharo-local/iceberg/pharo-project/pharo') resolve.
subdirectory := 'src'.
iceRep := IceRepositoryCreator new 
				repository: repository;
				remote: (IceGitRemote url: remoteUrl);
				location: location;
				subdirectory: subdirectory;
				createRepository.


userName ifNotNil: [ 
	githubRepository := IceGitHubAPI new 
		beAnonymous;
		getRepository: userName project: projectName.
	remoteUrl := 'git@github.com:', userName, '/pharo.git'.
	remote := IceGitRemote name: userName url: remoteUrl.
	repository addRemote: remote.
	remote fetch ].
```

It would then be worthwhile to repair the repository and create a branch from the image's commit (to be automated).


Load Threaded FFI, Iceberg / libgit extensions:

```
EpMonitor current disable.
[ 
Metacello new
	baseline: 'ThreadedFFI';
	repository: 'github://pharo-project/threadedFFI-Plugin/src';
	load.

Metacello new
	baseline: 'GtThreadedFFIDev';
	repository: 'github://feenkcom/tffi-dev/src';
	load.

MethodDictionaryConsistencyTest recompileInconsistent.

] ensure: [ EpMonitor current enable ].
```

Gtoolkit and other packages can then be loaded as normal:

```
EpMonitor current disable.
[ 
  Metacello new
    baseline: 'GToolkit';
    repository: 'github://feenkcom/gtoolkit/src';
    load
] ensure: [ EpMonitor current enable ].
```


To then run Pharo with Bloc graphics:

```
./pharo Pharo.image eval --no-quit 'UIManager default: BlBlocUIManager new. GtWorld open.'
```

To run Pharo with the old Morphic world:

```
./pharo-ui Pharo.image
```
