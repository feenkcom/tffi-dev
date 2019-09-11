Extension { #name : #LGitBlameOptions }

{ #category : #'*GToolkit-Iceberg' }
LGitBlameOptions >> blame_init_options: opts version: version [
	^ self
		callUnchecked: #(int git_blame_init_options(void * self, LGitOptionsVersionsEnum version))
		options: #( )
]
