Extension { #name : #IceLibgitRepository }

{ #category : #'*GToolkit-Iceberg' }
IceLibgitRepository >> remoteNamed: aName ifAbsent: aBlockClosure [
	
	self handleLibgitError: [ | gitRemote |
	[ gitRemote := (LGitRemote of: self repositoryHandle named: aName) lookup.
	^ (IceGitRemote name: gitRemote remoteName url: gitRemote url)
		localRepository: self;
		yourself ]
		on: LGitObjectNotInitialized, LGitObjectNotFound
		do: [ ^ aBlockClosure value ] ]
]
