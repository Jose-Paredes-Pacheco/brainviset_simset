!INTERFILE  :=
name of data file := PROJECTIONS_SIMSET
Originating System := Userdefined
!GENERAL DATA :=
!GENERAL IMAGE DATA :=
!type of data := PET
;applied corrections:={none}
;ASCII list, Static|Dynamic|Gated|Tomographic|Curve|ROI|PET|Other
imagedata byte order := LITTLEENDIAN
!PET STUDY (General) :=
!PET data type := Emission
;ASCII list que puede ser Emission|Transmission|Blank|AttenuationCorrection|Normalisation|Image
!number format := float
!number of bytes per pixel := 4

;Sinograms 3D
number of dimensions := 4
matrix axis label [4] := segment
!matrix size [4] := 3
matrix axis label [2] := view
!matrix size [2] := 312
matrix axis label [3] := axial coordinate
!matrix size [3] := {51,52,51}
matrix axis label [1] := tangential coordinate
!matrix size [1] := 312
minimum ring difference per segment := { -1,0,1 }
maximum ring difference per segment := { -1,0,1 }
Scanner type := SimSet
number of rings := 52
number of detectors per ring := 624
Inner ring diameter (cm) := 84.90
Average depth of interaction (cm) := 0.1
distance between rings (cm) := .4
Default bin size (cm) := .2
;Number of blocks per bucket in transaxial direction         := 1
;Number of blocks per bucket in axial direction              := 4
;Number of crystals per block in transaxial direction        := 8
;Number of crystals per block in axial direction             := 8
;Number of detector layers                                   := 1
;Number of crystals per singles unit in axial direction      := 32
;Number of crystals per singles unit in transaxial direction := 8
;end scanner parameters:=


effective central bin size (cm) := .2
data offset in bytes[1] := 0
number of time frames := 1
!END OF INTERFILE :=
