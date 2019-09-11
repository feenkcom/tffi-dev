Extension { #name : #LGitCloneOptions }

{ #category : #'*GToolkit-Iceberg' }
LGitCloneOptions >> clone_init_options: opts version: version [ 
	^ self
		callUnchecked: #(LGitReturnCodeEnum git_clone_init_options(void * self, LGitOptionsVersionsEnum version))
		options: #(  )
]

{ #category : #'*GToolkit-Iceberg' }
LGitCloneOptions >> prim_remote_cb: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_REMOTE_CB
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitCloneOptions >> prim_repository_cb: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_REPOSITORY_CB
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]
