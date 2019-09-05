Class {
	#name : #MessageSendMutation,
	#superclass : #Mutation,
	#instVars : [
		'mutatedSelector'
	],
	#category : #Mutator
}

{ #category : #factory }
MessageSendMutation class >> andToOr [
	"Beware, need to disable and/or inlining compiler optimisation!"
	^ self
		selectorToMutate: #and:
		mutatedSelector: #or:
]

{ #category : #factory }
MessageSendMutation class >> equalsToNotEquals [
	^ self
		selectorToMutate: #=
		mutatedSelector: #~=
]

{ #category : #factory }
MessageSendMutation class >> ifFalseIfTrueToIfTrueIfFalse [
	"Beware, need to disable if inlining compiler optimisation!"
	^ self
		selectorToMutate: #ifFalse:ifTrue:
		mutatedSelector: #ifTrue:ifFalse:
]

{ #category : #factory }
MessageSendMutation class >> ifFalseToIfTrue [
	"Beware, need to disable if inlining compiler optimisation!"
	^ self
		selectorToMutate: #ifFalse:
		mutatedSelector: #ifTrue:
]

{ #category : #factory }
MessageSendMutation class >> ifTrueIfFalseToIfFalseIfTrue [
	"Beware, need to disable if inlining compiler optimisation!"
	^ self
		selectorToMutate: #ifTrue:ifFalse:
		mutatedSelector: #ifFalse:ifTrue:
]

{ #category : #factory }
MessageSendMutation class >> ifTrueToIfFalse [
	"Beware, need to disable if inlining compiler optimisation!"
	^ self
		selectorToMutate: #ifTrue:
		mutatedSelector: #ifFalse:
]

{ #category : #factory }
MessageSendMutation class >> notRemover [
	^ self
		selectorToMutate: #not
		mutatedSelector: #yourself
]

{ #category : #factory }
MessageSendMutation class >> orToAnd [
	"Beware, need to disable and/or inlining compiler optimisation!"
	^ self
		selectorToMutate: #or:
		mutatedSelector: #and:
]

{ #category : #'instance creation' }
MessageSendMutation class >> selectorToMutate: aSymbol mutatedSelector: mutatedSelector [
	^ self new
		selectorToMutate: aSymbol;
		mutatedSelector: mutatedSelector;
		yourself
]

{ #category : #private }
MessageSendMutation >> buildMetaLink [
	^ MetaLink new
		metaObject: self;
		control: #instead;
		selector: #executeMutationFor:arguments:;
		arguments: #(receiver arguments);
		yourself
]

{ #category : #private }
MessageSendMutation >> executeMutationFor: receiver arguments: arguments [
	^ receiver perform: self mutatedSelector withArguments: arguments
]

{ #category : #accessing }
MessageSendMutation >> mutatedSelector [
	^ mutatedSelector
]

{ #category : #accessing }
MessageSendMutation >> mutatedSelector: anObject [
	mutatedSelector := anObject
]

{ #category : #accessing }
MessageSendMutation >> selectorToMutate: aSymbol [
	self matcherBlock: [ :node | node class = RBMessageNode and: [ node selector = aSymbol ] ]
]
