Extension { #name : #LGitDiffSimilarityMetric }

{ #category : #'*GToolkit-Iceberg' }
LGitDiffSimilarityMetric >> prim_file_signature: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_FILE_SIGNATURE
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitDiffSimilarityMetric >> prim_free_signature: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_FREE_SIGNATURE
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]

{ #category : #'*GToolkit-Iceberg' }
LGitDiffSimilarityMetric >> prim_similarity: anObject [
	"This method was automatically generated"
	handle 
		pointerAt: OFFSET_PRIM_SIMILARITY
		put: (anObject 
			ifNotNil: [ anObject thunk asExternalAddress ]
			ifNil: [ ExternalAddress null ])
]
