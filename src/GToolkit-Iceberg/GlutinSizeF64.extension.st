Extension { #name : #GlutinSizeF64 }

{ #category : #'*GToolkit-Iceberg' }
GlutinSizeF64 class >> externalNew [

	| created |

	created := self primCreate.
	created class = self ifTrue: [ ^created ].
	^ self basicNew setHandle: created
]
