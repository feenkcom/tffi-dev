Extension { #name : #LGitReadStream }

{ #category : #'*GToolkit-Iceberg' }
LGitReadStream >> position [ 
	"Answer the position of the receiver.
	Exposing the position allows users to do optimisations such as pre-allocating a buffer of the correct size when reading."

	^position
]
