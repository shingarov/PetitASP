Class {
	#name : #BaselineOfPetitASP,
	#superclass : #Object,
	#category : #BaselineOfPetitASP
}

{ #category : #baselines }
BaselineOfPetitASP >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [ 
			spec
				package: #'PetitASP';
				package: #'PetitASP-Tests'.
			]
]
