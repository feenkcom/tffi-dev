Extension { #name : #LGitCommit }

{ #category : #'*GToolkit-Iceberg' }
LGitCommit >> author [
	^ LGitSignature fromHandle: (self commit_author: self)
]

{ #category : #'*GToolkit-Iceberg' }
LGitCommit >> commit_author: commit [
	
	^ self
		call: #(void * git_commit_author #(self))
		options: #()
]

{ #category : #'*GToolkit-Iceberg' }
LGitCommit >> commit_committer: commit [
	
	^ self
		call: #(void * git_commit_committer #(self))
		options: #()
]

{ #category : #'*GToolkit-Iceberg' }
LGitCommit >> committer [
	^ LGitSignature fromHandle: (self commit_committer: self)
]

{ #category : #'*GToolkit-Iceberg' }
LGitCommit >> committerStruct [
	^ LGitSignature fromHandle: (self commit_committer: self)
]
