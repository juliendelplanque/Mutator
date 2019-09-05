Class {
	#name : #Mutation,
	#superclass : #Object,
	#instVars : [
		'matcherBlock'
	],
	#category : #Mutator
}

{ #category : #private }
Mutation >> buildMetaLink [
	"Returns the MetaLink instance that will implement the mutation."
	^ self subclassResponsibility
]

{ #category : #curing }
Mutation >> cure: aMethod [ 
	aMethod ast allChildren
		select: self matcherBlock
		thenDo: [ :node |
			node links
				select: [ :metalink | metalink metaObject == self ]
				thenDo: [ :metalink | node removeLink: metalink ] ]
]

{ #category : #accessing }
Mutation >> matcherBlock [
	^ matcherBlock
]

{ #category : #accessing }
Mutation >> matcherBlock: anObject [
	matcherBlock := anObject
]

{ #category : #mutating }
Mutation >> mutate: aMethod [
	aMethod ast allChildren
		select: self matcherBlock
		thenDo: [ :node | 
			(node links anySatisfy: [ :any | any metaObject isKindOf: Mutation])
				ifTrue: [ NodeAlreadyMutated signalForAstNode: node ].
			node link: self buildMetaLink ]
]
