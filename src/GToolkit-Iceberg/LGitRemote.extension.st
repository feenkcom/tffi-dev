Extension { #name : #LGitRemote }

{ #category : #'*GToolkit-Iceberg' }
LGitRemote >> fetch [
	self isReady ifFalse: [ self create ].

	self withReturnHandlerDo: [ 
		ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
		self
			tFFIremote_fetch: self
			refspecs: self ffiNull handle
			opts: (LGitFetchOptions defaults
				callbacks: LGitRemoteCallbacks defaults;
				yourself)
			reflog_message: nil ]
		ifFalse: [ 
		self
			remote_fetch: self
			refspecs: self ffiNull handle
			opts: (LGitFetchOptions defaults
				callbacks: LGitRemoteCallbacks defaults;
				yourself)
			reflog_message: nil ] ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemote >> fetchWithCredentials: aCredentialsProvider andProgressCallback: progressCallback refSpec: aRefSpec [
	| refSpecs callbacks |
	self isReady ifFalse: [ self create ].
	refSpecs := aRefSpec ifNotNil: [LGitStringArray withAll: { aRefSpec asString }].
	self withReturnHandlerDo: [ 
		
		callbacks := LGitRemoteCallbacks withProvider: aCredentialsProvider.
		progressCallback ifNotNil: [callbacks transferProgress: progressCallback].

		ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
		self
			tFFIremote_fetch: self
			refspecs: refSpecs
			opts: (LGitFetchOptions defaults
				callbacks:callbacks;
				yourself)
			reflog_message: nil ]
		ifFalse: [ 
		self
			remote_fetch: self
			refspecs: refSpecs
			opts: (LGitFetchOptions defaults
				callbacks:callbacks;
				yourself)
			reflog_message: nil 
		] ]
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemote >> fetchWithMessage: aString [
	self create.

	self withReturnHandlerDo: [ 
		ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
		self
			tFFIremote_fetch: self
			refspecs: nil
			opts: LGitFetchOptions defaults
			reflog_message: aString ]
		ifFalse: [ 
		self
			remote_fetch: self
			refspecs: nil
			opts: LGitFetchOptions defaults
			reflog_message: aString ] ]

]

{ #category : #'*GToolkit-Iceberg' }
LGitRemote >> fetchWithMessage: aString credentials: aCredentialsProvider [ 
	self create.
		
	self withReturnHandlerDo: [ 
		ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
		self
			tFFIremote_fetch: self
			refspecs: nil
			opts: (LGitFetchOptions defaults
				callbacks: (LGitRemoteCallbacks withProvider: aCredentialsProvider);
				yourself)
			reflog_message: aString ]
		ifFalse: [ 
		self
			remote_fetch: self
			refspecs: nil
			opts: (LGitFetchOptions defaults
				callbacks: (LGitRemoteCallbacks withProvider: aCredentialsProvider);
				yourself)
			reflog_message: aString ] ]

]

{ #category : #'*GToolkit-Iceberg' }
LGitRemote >> pullWithFetchOptions: fetchOptions [
	<todo: 'check for conflicts'>
	self repository isReady ifFalse: [  ^ self ].

	self lookup.
	
	self withReturnHandlerDo: [ 
		ThreadedFFIMigration threadedFFIAvailable ifTrue: [ 
		self
			tFFIremote_fetch: self
			refspecs: nil
			opts: fetchOptions
			reflog_message: 'automatic pull from libgit2' ]
		ifFalse: [ 
		self
			remote_fetch: self
			refspecs: nil
			opts: fetchOptions
			reflog_message: 'automatic pull from libgit2' ] ].
	
	"assume that there are no conflicts and fast-forwad to FETCH_HEAD"
	self repository fastForward
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemote >> tFFIremote_fetch: remote refspecs: refspecs opts: opts reflog_message: reflog_message [
	
	"^ self
		call:
			#(LGitReturnCodeEnum git_remote_fetch #(self , LGitStringArray * refspecs , LGitFetchOptions * opts , String reflog_message))
		options: #(optCoerceNilToNull)"

	| function |

	function := TFExternalFunction
		name: 'git_remote_fetch'
		moduleName: self ffiLibraryName uniqueInstance unixModuleName
		definition: (TFFunctionDefinition
			parameterTypes: { TFBasicType pointer. TFBasicType pointer. TFBasicType pointer. TFBasicType uchar }
			returnType: TFBasicType sint).
	^TFSameThreadRunner new invokeFunction: function withArguments: 
		{ self.
		refspecs ifNil: [ ExternalAddress null ].
		opts ifNil: [ ExternalAddress null ].
		reflog_message ifNil: [ ExternalAddress null ]. }
]
