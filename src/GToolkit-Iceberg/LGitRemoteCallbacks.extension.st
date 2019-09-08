Extension { #name : #LGitRemoteCallbacks }

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> prim_completion: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_COMPLETION
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> prim_credentials: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_CREDENTIALS
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> prim_pack_progress: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_PACK_PROGRESS
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> prim_push_negotiation: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_PUSH_NEGOTIATION
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> prim_push_transfer_progress: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_PUSH_TRANSFER_PROGRESS
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> prim_push_update_reference: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_PUSH_UPDATE_REFERENCE
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> prim_sideband_progress: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_SIDEBAND_PROGRESS
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> prim_transfer_progress: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_TRANSFER_PROGRESS
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> prim_update_tips: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_UPDATE_TIPS
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitRemoteCallbacks >> remote_init_callbacks: opts version: version [ 
	^ self
		call: #(LGitReturnCodeEnum git_remote_init_callbacks(LGitRemoteCallbacks * self, LGitStructVersionsEnum version))
		options: #(  )
]
