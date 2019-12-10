| iceRep repository remoteUrl location subdirectory userName projectName githubRepository remote |

"If you have a private fork of the pharo repository, set your username below (as a String) and it will be added as a remote"
userName := 'akgrant43'.
Author fullName: 'AlistairGrant'.

"Ensure the white theme"
PharoLightTheme beCurrent.


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


EpMonitor disableDuring:
[ 
Metacello new
	baseline: 'ThreadedFFIMigration';
	repository: 'github://feenkcom/tffi-dev/src';
	load.

Metacello new
	baseline: 'GToolkit';
	repository: 'github://feenkcom/gtoolkit/src';
	load.

GTGenericStackDebugger register.

Metacello new
	baseline: 'ThreadedFFI';
	repository: 'github://feenkcom/threadedFFI-Plugin/src';
	load.

Metacello new
	baseline: 'GtThreadedFFIDev';
	repository: 'github://feenkcom/tffi-dev/src';
	load.

"#MethodDictionaryConsistencyTest asClass recompileInconsistent."
].
