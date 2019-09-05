Class {
	#name : #BaselineOfMutator,
	#superclass : #BaselineOf,
	#category : #BaselineOfMutator
}

{ #category : #baselines }
BaselineOfMutator >> baseline: spec [
	<basline>
	spec for: #common do: [ 
		spec package: 'Mutator'.
		spec package: 'Mutator-Tests' with: [ spec requires: #('Mutator') ] ]
]
