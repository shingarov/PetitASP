Class {
	#name : #'EZ_ezcsp__geq',
	#superclass : #EzCspIntCompare,
	#category : #PetitASP
}

{ #category : #'as yet unclassified' }
EZ_ezcsp__geq >> toBool [
	arguments size = 2 ifFalse: [ self error ].
	^ arguments first toInt >= arguments second toInt
]
