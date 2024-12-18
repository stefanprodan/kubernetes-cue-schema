// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1

package v1

_#cborMajorType: int

// https://www.rfc-editor.org/rfc/rfc8949.html#section-3.1
_#cborUnsignedInteger: _#cborMajorType & 0
_#cborNegativeInteger: _#cborMajorType & 1
_#cborByteString:      _#cborMajorType & 2
_#cborTextString:      _#cborMajorType & 3
_#cborArray:           _#cborMajorType & 4
_#cborMap:             _#cborMajorType & 5
_#cborTag:             _#cborMajorType & 6
_#cborOther:           _#cborMajorType & 7

// from https://www.rfc-editor.org/rfc/rfc8949.html#name-jump-table-for-initial-byte.
// additionally, see https://www.rfc-editor.org/rfc/rfc8949.html#section-3.3-5.
_#cborFalseValue: 0xf4
_#cborTrueValue:  0xf5
_#cborNullValue:  0xf6
