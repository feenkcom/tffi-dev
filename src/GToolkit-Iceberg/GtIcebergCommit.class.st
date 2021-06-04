"
GtIcebergCommit can be used to commit the current image changes to the supplied repositories current branch.


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	commitMessage:		<Object>
	repository:		<Object>


    Implementation Points

"
Class {
	#name : #GtIcebergCommit,
	#superclass : #Object,
	#instVars : [
		'repository',
		'commitMessage',
		'repositoryModel',
		'cachedModel'
	],
	#category : #'GToolkit-Iceberg'
}

{ #category : #'instance creation' }
GtIcebergCommit class >> on: anIceRepository [

	^self new repository: anIceRepository
]

{ #category : #accessing }
GtIcebergCommit >> commitMessage [
	^ commitMessage
]

{ #category : #accessing }
GtIcebergCommit >> commitMessage: anObject [
	commitMessage := anObject
]

{ #category : #actions }
GtIcebergCommit >> doCommit [ 
	"Commit the receiver and answer an object that indicates the result of the commit"

	self model commit:
			(IceTipCommitAction new
				diff: self model workingCopyDiff;
				items: 'aCollection';
				message: 'aString';
				yourself)

]

{ #category : #accessing }
GtIcebergCommit >> executeCommit [
	|diff|
	diff := self repository workingCopyDiff.
	Iceberg announcer announce: (IceRepositoryModified for: self repository).
	self repository workingCopy 
		commitChanges: diff
		withMessage: self commitMessage
		force: false.
	
]

{ #category : #ui }
GtIcebergCommit >> gtActionCommitFor: anAction [
	<gtAction>
	"self commitMessage ifNil: [ ^ anAction  ]."
	^ anAction button
		label: 'Commit';
		action: [ :aButton | 
			aButton phlow spawnObject: 
				self executeCommit ]
]

{ #category : #accessing }
GtIcebergCommit >> gtMessageEditorFor: aView [
	<gtView>
	^ aView explicit
		title: 'Message';
		stencil: [
			|editor|
			editor := BrEditor new look: BrGlamorousRegularEditorLook new.
			editor text: commitMessage.
			editor editor when: BrTextEditorModifiedEvent do: [ :anEvent | self commitMessage: anEvent text asString ].
			editor]
]

{ #category : #accessing }
GtIcebergCommit >> model [ 

	^ cachedModel ifNil: [ cachedModel := IceTipCachedModel on: self repositoryModel ]
]

{ #category : #accessing }
GtIcebergCommit >> repository [
	^ repository
]

{ #category : #accessing }
GtIcebergCommit >> repository: anObject [
	repository := anObject
]

{ #category : #accessing }
GtIcebergCommit >> repositoryModel [

	^ repositoryModel ifNil: [ repositoryModel := IceTipRepositoryModel on: self repository ]
]
