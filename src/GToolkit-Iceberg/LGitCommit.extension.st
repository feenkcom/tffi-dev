Extension { #name : #LGitCommit }

{ #category : #'*GToolkit-Iceberg' }
LGitCommit >> author [
	^ LGitSignature fromHandle: (self commit_author: self)
]
