Class {
	#name : #LibEzSMT,
	#superclass : #FFILibrary,
	#category : #PetitASP
}

{ #category : #API }
LibEzSMT >> ezsmt: program [
	^ self ffiCall: #( char* ezsmt ( char* program ) )
]

{ #category : #'accessing platform' }
LibEzSMT >> unix64LibraryName [
	^ '/home/boris/work/EZSMT/libezsmt.so'
]

{ #category : #'accessing platform' }
LibEzSMT >> unix64ModuleName [
	^ '/home/boris/work/EZSMT/libezsmt.so'
]
