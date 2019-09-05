Class {
	#name : #Mutator,
	#superclass : #Object,
	#instVars : [
		'name',
		'mutations'
	],
	#category : #Mutator
}

{ #category : #curing }
Mutator >> cure: aMethod [
	self mutations do: [ :mutation |
		mutation cure: aMethod ]
]

{ #category : #mutating }
Mutator >> mutate: aMethod [
	self mutations doWithIndex: [ :mutation :i |
		[ 
			mutation mutate: aMethod
		] on: NodeAlreadyMutated do: [ :error |
		self mutations from: 1 to: i - 1 do: [ :mutationToCure |
			mutationToCure cure: aMethod ].
		error pass ] ]
]

{ #category : #accessing }
Mutator >> mutations [
	^ mutations
]

{ #category : #accessing }
Mutator >> mutations: anObject [
	mutations := anObject
]

{ #category : #accessing }
Mutator >> name [
	^ name
]

{ #category : #accessing }
Mutator >> name: anObject [
	name := anObject
]
