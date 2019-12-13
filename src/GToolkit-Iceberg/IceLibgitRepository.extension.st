Extension { #name : #IceLibgitRepository }

{ #category : #'*GToolkit-Iceberg' }
IceLibgitRepository >> remoteNamed: aName ifAbsent: aBlockClosure [

	(self remotes anySatisfy: [ :aRemote | aRemote name = aName ])
		ifFalse: [ ^ aBlockClosure value ].
	
	self handleLibgitError: [ | gitRemote |
	[ gitRemote := (LGitRemote of: self repositoryHandle named: aName) lookup.
	^ (IceGitRemote name: gitRemote remoteName url: gitRemote url)
		localRepository: self;
		yourself ]
		on: LGitObjectNotInitialized
		do: [ ^ aBlockClosure value ] ]
]
