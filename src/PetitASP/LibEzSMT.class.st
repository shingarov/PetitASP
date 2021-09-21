Class {
	#name : #LibEzSMT,
	#superclass : #FFILibrary,
	#category : #PetitASP
}

{ #category : #API }
LibEzSMT >> ezsmt_clausify: ez _: program [
	^ self ffiCall: #( char* ezsmt_clausify ( void* ez, char* program ) )
]

{ #category : #API }
LibEzSMT >> ezsmt_del: ez [
	^ self ffiCall: #( void ezsmt_del ( void* ez ) )
]

{ #category : #API }
LibEzSMT >> ezsmt_get_error: ez [
	^ self ffiCall: #( char* ezsmt_get_error ( void* ez ) )
]

{ #category : #API }
LibEzSMT >> ezsmt_mk [
	^ self ffiCall: #( void* ezsmt_mk () )
]

{ #category : #'accessing platform' }
LibEzSMT >> unix64LibraryName [
	^ '/home/boris/work/EZSMTplus/libezsmt.so'
]

{ #category : #'accessing platform' }
LibEzSMT >> unix64ModuleName [
	^ '/home/boris/work/EZSMTplus/libezsmt.so'
]
