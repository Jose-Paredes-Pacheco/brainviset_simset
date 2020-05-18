#!/usr/bin/env bash
#####################################################################################
# Authors:
# Aida Niñerola
# Gemma Salvadó
# Modified by:
# Jesús Silva
#####################################################################################
# Date: Oct 2018
# Description: Initial parameters for Simulation and reconstruction
# Version: 1
#####################################################################################

DIR_STIR=/usr/local/bin #/opt/STIR-Github/install/bin
DIR_SIMSET=/opt/SimSET/2.9.2 #/opt/SIMSET/2.9.2
SPM_RUN="/media/usuario3/HDD/SPM_standalone/spm12/run_spm12.sh /media/usuario3/HDD/SPM_standalone/MCR/v713 batch" #"/home/jesus/Work/Neurocloud/neurocloud-core/include/spm12/run_spm12.sh /opt/MATLAB/MATLAB_Compiler_Runtime/v901/ batch"

# Make CESGA =1 to run in Cesga. Let it be 0 to run at single PC
CESGA=0
CESGA_DATA_PATH=$LUSTRE/SimPET/brainviset_simset
cesga_max_time=02:00:00

# -----------------------------------
# --------SUBJECT VARIABLES ---------
# -----------------------------------

# PET system (Siemens_mCT, GE_Discovery, GE_Advance)
scanner=GE_Discovery
# ID simulation

patient=C16_roiAD_0_1
act_map=newMap_new_roiAD_0.1
att_map=Ctrl_16.att_newDim
pet_image=newMap_new_roiAD_0.1
output_name=$patient
min_cc=0.99  #Minimun cross-correlation coefficient for stopping the iterations

#patient=CerebroCTLN
#act_map=mapa_act_centrado3
#att_map=mapa_att_centrado3
#pet_image=mapa_act_centrado3

#patient=NEMA_ImageQuality
#act_map=xrIEC_NEMA_ACT_N4
#att_map=cxrIEC_NEMA_ATT
#pet_image=xrIEC_NEMA_ACT_N4

# User intervention - 0:manual 1:automatic
user=1

# --------------------------------------
# --------BRAINVISET PARAMETERS---------
# --------------------------------------

maximumIteration=1

if [ $maximumIteration == 1 ];then
    pet_image=$act_map
fi

# -----------------------------------
# --------PHANTOM VARIABLES ---------
# -----------------------------------

# Central Slice
corte_central=140 #144 #150 #152 #140 #140 #95 #128  #90

# ACTTABLE= If 1 new activity table is calculated in order to fit the given dose.
ACTTABLE=1
DOSE=1.25 #1.25 # 0.33 #2 #1.25 # mCi

# --------------------------------------
# ----------SIMSET PARAMETERS-----------
# --------------------------------------

#simulation process (activated = 1 - deactivated = 0)
simulation=1

#reconstruction process (activated = 1 - deactivated = 0)
reconstruction=1

#Number os subprocesses for parallel simulation
division=8

# PRESERVE_FILES= If 0 the files produced by the phg are deleted when the reconstruction is starting.
# Any other value preserves the phg output files
PRESERVE_FILES=1

# noisefree=-1 for no factors directly w neq w2( First simulation runs SAMPLINGPHOTONS,second one runs PHOTONS)
# noisefree=0 for simulations w=w2 (First simulation runs SAMPLINTPHOTONS, second one calculates SAMPLINGPHOTONS*w2/w
# noisefree=1 for simulation w=100*w2 (Calculates as noisefree=0)
noisefree=0

# Numero de fotones a simular
SAMPLINGPHOTONS=100000
PHOTONS=1000000
LENGTH=186 #186

# Parameros para separar fotones dispersados
# Ej: 3-0-3 Proporciona matriz 9x9, as� 0-0,0-1,0-2,0->2,1-0,1-1...
# Ej: 1-0-9 Proporciona matriz 1x2, as� 0-0,0->1.
# m�s posibilidades en SimSET web site.
scatter_param=1
min_s=0
max_s=9

#SCATTER_CORRECTION_FACTOR is applying and analytical correction on SCATTER SINOGRAMS. 0.15 WILL REMOVE 85% of scatter.
#SCATTER_CORRECTION_FACTOR=0 for trues only
ANALYTIC_SCATTER_CORRECTIONFACTOR=0.15

# Photon Physics (true o false), ojo por defecto simula 18-F sino cambiar en ../data/template_phg
positron_range=true
no_colinearidad=true

# Output File (donde se escribe matriz de sinogramas)
ANALYZE=1

# -----------------------------
# ----- SCANNER VARIABLES -----
# -----------------------------

if [ $scanner == "Siemens_mCT" ];then
    # Radio del cilindro detector del scanner (cm)
    radio_scanner=42.45
    # Numero de anillos del scanner (cm)
    num_z_bins=52
    max_segment=49
    # Limites del binado en z (cm)
    min_z=-10.9
    max_z=10.9
    # Numero de angulos almacenados (mashing)
    num_aa_bins=312
    # N�mero de detectores por anillo divido por 2
    # Dimensiones del FOV (min-max) (cm)
    num_td_bins=312
    min_td=-31.2
    max_td=31.2
    # Valor del m�nimo de la ventana de energ�a (en keV)
    min_energy_window=435
    zoomFactor=1		  #Zoom factor in x and y
    xyOutputSize=256 	  #Reconstruction matrix
    zOutputSize=103 	  #Number of slices of the reconstruction
    numberOfSubsets=26	  #Number of subsets
    numberOfIterations=26 #520   #Number of iterations
    savingInterval=26	  #The interval that we want to save intermediate iterations images

    B_ATTEN_PAR=""
    B_SCATT_PAR=""
fi

if [ $scanner == "GE_Advance" ];then
    # Radio del cilindro detector del scanner (cm)
    radio_scanner=46.20
    # Numero de anillos del scanner (cm)
    num_z_bins=18
    max_segment=17
    # Limites del binado en z (cm)
    min_z=-7.6
    max_z=7.6
    # Numero de angulos almacenados (mashing)
    num_aa_bins=336
    # N�mero de detectores por anillo divido por 2
    # Dimensiones del FOV (min-max) (cm)
    num_td_bins=281
    min_td=-56.2
    max_td=56.2
    # Valor del m�nimo de la ventana de energ�a (en keV)
    min_energy_window=375
    #Reconstruction Parameters
    zoomFactor=1		  #Zoom factor in x and y
    xyOutputSize=128 	  #Reconstruction matrix
    zOutputSize=35 	  #Number of slices of the reconstruction
    numberOfSubsets=28	  #Number of subsets
    numberOfIterations=560 #520   #Number of iterations
    savingInterval=28	  #The interval that we want to save intermediate iterations images

    B_ATTEN_PAR=";"
    B_SCATT_PAR=";"
fi

if [ $scanner == "GE_Discovery" ];then

    # Detector model. Avaliable Options: cylindrical, simplepet
    detector_model=simplepet

    if [ $detector_model == "simplepet" ] || [ $detector_model == "cylindrical" ];then
        # Radio del cilindro detector del scanner (cm)
        radio_scanner=44.31
        # Limites del binado en z (cm)
        min_z=-7.85
        max_z=7.85
    fi

    
    # Numero de anillos del scanner (cm)
    num_z_bins=24
    max_segment=23
    
    # Numero de angulos almacenados (mashing)
    num_aa_bins=280
    # N�mero de detectores por anillo divido por 2
    # Dimensiones del FOV (min-max) (cm)
    num_td_bins=293
    min_td=-35.11605
    max_td=35.11605
    # Valor del m�nimo de la ventana de energ�a (en keV)
    min_energy_window=375
    #Reconstruction Parameters
    zoomFactor=1.23		  #Zoom factor in x and y
    xyOutputSize=128 	  #Reconstruction matrix
    zOutputSize=47 	  #Number of slices of the reconstruction
    numberOfSubsets=7	  #Number of subsets
    numberOfIterations=32 #32 #Number of iterations
    savingInterval=32	#8  #The interval that we want to save intermediate iterations images

    # Value of the PSF to modify the sinograms
    psf_value=1.125

    B_ATTEN_PAR=""
    B_SCATT_PAR=";"
fi

# ------------------------------------------
# --------RECONSTRUCTION PARAMETERS---------
# ------------------------------------------

#Name of hdr template
recPETHeader=Reconstruction

#Reconstruction type
# 0: OSEM 2D (2N+1)
# 1: OSEM fully3D (all sinograms)
# 2: FBP 3D (all sinograms)
recons_type=1

if [ $recons_type -eq 0 ];
then
	reconstructionFileName=$DIR_RECONSTRUCTIONS/rec_OSEM2D
	recFileName=rec_OSEM2D
    max_segment=1 
fi

if [ $recons_type -eq 1 ];
then
	reconstructionFileName=$DIR_RECONSTRUCTIONS/rec_OSEM3D
	recFileName=rec_OSEM3D
fi
if [ $recons_type -eq 2 ];
then
        reconstructionFileName=$DIR_RECONSTRUCTIONS/rec_FBP3DRP
        recFileName=rec_FBP3DRP
fi


##########################################
##################SETUP###################
##########################################


