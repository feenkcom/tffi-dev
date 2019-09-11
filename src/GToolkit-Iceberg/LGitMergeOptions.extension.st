Extension { #name : #LGitMergeOptions }

{ #category : #'*GToolkit-Iceberg' }
LGitMergeOptions >> merge_init_options: opts version: version [ 
	^ self
		callUnchecked: #(int git_merge_init_options(
			void * self, 
			LGitOptionsVersionsEnum version))
		options: #()
]
