Class {
	#name : #LiteralMutation,
	#superclass : #Mutation,
	#instVars : [
		'mutatedLiteralValue'
	],
	#category : #Mutator
}

{ #category : #'instance creation' }
LiteralMutation class >> literalValueToMutate: literalValueToMutate mutatedLiteralValue: mutatedLiteralValue [
	^ self new
		literalValueToMutate: literalValueToMutate;
		mutatedLiteralValue: mutatedLiteralValue;
		yourself
]

{ #category : #private }
LiteralMutation >> buildMetaLink [
	^ MetaLink new
		metaObject: self;
		control: #instead;
		selector: #mutatedLiteralValue;
		yourself
]

{ #category : #accessing }
LiteralMutation >> literalValueToMutate: aLiteralValue [
	self matcherBlock: [ :node | node class = RBLiteralValueNode and: [ node value = aLiteralValue ] ]
]

{ #category : #accessing }
LiteralMutation >> mutatedLiteralValue [
	^ mutatedLiteralValue
]

{ #category : #accessing }
LiteralMutation >> mutatedLiteralValue: anObject [
	mutatedLiteralValue := anObject
]
