Class {
	#name : #'EZ_ezcsp__pl',
	#superclass : #EzCspIntOperator,
	#category : #PetitASP
}

{ #category : #converting }
EZ_ezcsp__pl >> toInt [
	arguments size = 2 ifFalse: [self shouldBeImplemented].
	^arguments first toInt + arguments second toInt
]
