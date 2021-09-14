Class {
	#name : #'EZ_ezcsp__leq',
	#superclass : #EzCspIntCompare,
	#category : #PetitASP
}

{ #category : #converting }
EZ_ezcsp__leq >> toBool [
	arguments size = 2 ifFalse: [ self error ].
	^ arguments first toInt <= arguments second toInt
]
