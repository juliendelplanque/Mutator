Class {
	#name : #NodeAlreadyMutated,
	#superclass : #Error,
	#instVars : [
		'astNode'
	],
	#category : #Mutator
}

{ #category : #'instance creation' }
NodeAlreadyMutated class >> signalForAstNode: astNode [
	^ self new
		astNode: astNode;
		signal
]

{ #category : #accessing }
NodeAlreadyMutated >> astNode [
	^ astNode
]

{ #category : #accessing }
NodeAlreadyMutated >> astNode: anObject [
	astNode := anObject
]
