Extension { #name : #LGitRemote }

{ #category : #'*GToolkit-Iceberg' }
LGitRemote >> remote_fetch: remote refspecs: refspecs opts: opts reflog_message: reflog_message [
	
	^ self
		call:
			#(LGitReturnCodeEnum git_remote_fetch #(self , void * refspecs , void * opts , String reflog_message))
		options: #(optCoerceNilToNull)
]
