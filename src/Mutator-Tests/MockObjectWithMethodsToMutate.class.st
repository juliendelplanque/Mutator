Class {
	#name : #MockObjectWithMethodsToMutate,
	#superclass : #Object,
	#category : #'Mutator-Tests'
}

{ #category : #'to mutate' }
MockObjectWithMethodsToMutate >> methodToMutate [
	^ 1 = 2
]

{ #category : #'to mutate' }
MockObjectWithMethodsToMutate >> methodToMutateWithIfTrueIfFalse [
	^ true
		ifFalse: [ 0 ]
		ifTrue: [ 42 ]
]
