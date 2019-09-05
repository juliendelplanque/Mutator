"
A LiteralMutationTest is a test class for testing the behavior of LiteralMutation
"
Class {
	#name : #LiteralMutationTest,
	#superclass : #TestCase,
	#category : #'Mutator-Tests'
}

{ #category : #running }
LiteralMutationTest >> tearDown [
	"Make sure all modified AST with metalinks are reset via compilation."
	MockObjectWithMethodsToMutate recompile.
	super tearDown
]

{ #category : #tests }
LiteralMutationTest >> testMutate [
	| mock mutation |
	mock := MockObjectWithMethodsToMutate new.
	mutation := LiteralMutation literalValueToMutate: 1 mutatedLiteralValue: 2.
	
	self deny: mock methodToMutate.
	
	mutation mutate: MockObjectWithMethodsToMutate >> #methodToMutate.
	
	self assert: mock methodToMutate.
	
	mutation cure: MockObjectWithMethodsToMutate >> #methodToMutate.
	
	self deny: mock methodToMutate.
]
