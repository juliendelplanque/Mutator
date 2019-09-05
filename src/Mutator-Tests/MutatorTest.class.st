"
A MutatorTest is a test class for testing the behavior of Mutator
"
Class {
	#name : #MutatorTest,
	#superclass : #TestCase,
	#category : #'Mutator-Tests'
}

{ #category : #running }
MutatorTest >> tearDown [
	"Make sure all modified AST with metalinks are reset via compilation."
	MockObjectWithMethodsToMutate recompile.
	super tearDown
]

{ #category : #test }
MutatorTest >> testDoubleMutate [
	| mock mutator |
	mock := MockObjectWithMethodsToMutate new.
	mutator := Mutator new
					mutations: { 
						MessageSendMutation equalsToNotEquals.
						LiteralMutation literalValueToMutate: 1 mutatedLiteralValue: 2 };
					yourself.
	
	self deny: mock methodToMutate.
	
	mutator mutate: MockObjectWithMethodsToMutate >> #methodToMutate.
	
	self deny: mock methodToMutate.
	
	mutator cure: MockObjectWithMethodsToMutate >> #methodToMutate.
	
	self deny: mock methodToMutate.
]

{ #category : #test }
MutatorTest >> testDoubleMutateRaisesError [
	| mock mutator |
	mock := MockObjectWithMethodsToMutate new.
	mutator := Mutator new
					mutations: { MessageSendMutation equalsToNotEquals. MessageSendMutation equalsToNotEquals };
					yourself.
	
	self should: [ mutator mutate: MockObjectWithMethodsToMutate >> #methodToMutate ]
		raise: NodeAlreadyMutated
]

{ #category : #test }
MutatorTest >> testMutate [
	| mock mutator |
	mock := MockObjectWithMethodsToMutate new.
	mutator := Mutator new
					mutations: { MessageSendMutation equalsToNotEquals };
					yourself.
	
	self deny: mock methodToMutate.
	
	mutator mutate: MockObjectWithMethodsToMutate >> #methodToMutate.
	
	self assert: mock methodToMutate.
	
	mutator cure: MockObjectWithMethodsToMutate >> #methodToMutate.
	
	self deny: mock methodToMutate.
]

{ #category : #test }
MutatorTest >> testMutate2 [
	| mock mutator |
	mock := MockObjectWithMethodsToMutate new.
	mutator := Mutator new
					mutations: { MessageSendMutation ifFalseIfTrueToIfTrueIfFalse };
					yourself.
	
	self assert: mock methodToMutateWithIfTrueIfFalse equals: 42.
	
	mutator mutate: MockObjectWithMethodsToMutate >> #methodToMutateWithIfTrueIfFalse.
	
	self assert: mock methodToMutateWithIfTrueIfFalse equals: 0.
	
	mutator cure: MockObjectWithMethodsToMutate >> #methodToMutateWithIfTrueIfFalse.
	
	self assert: mock methodToMutateWithIfTrueIfFalse equals: 42.
]
