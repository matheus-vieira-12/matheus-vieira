#INCLUDE 'TOTVS.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TBICONN.CH'

/**************************************************************************************************
{Protheus.doc} Fferias10
@description	Programacao de ferias
@type   		WSRESTFUL	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		01/11/2022
@database		01/11/2022
@country		Brasil
@language		PT-BR
@obs			01/11/2022 - Controle de documentacao
@param			
@return		    Nil 				
*****************************************************************************************************/

User Function Fferias10(oJson, _cMatricula, _cNome, _dEmissao, _cNomeCmp, _cNomeMae, _cNomePai, _cSexo, _aArray, _cMsg)
Local nY           := 0
Local _cFilial     := "" 
Local _cMat        := ""
Local _cPd         := ""
Local _dDatabas    := ""
Local _dDataFim    := ""
Local _nDiasdir    := 0
Local _nDfervat    := 0
Local _nDferaat    := 0

    RecLock("SRA", .T.)

        SRA->RA_FILIAL  := FWxFilial("SRA")
        SRA->RA_MAT     := _cMatricula 
        SRA->RA_NOME    := _cNome
        SRA->RA_ADMISSA := Stod(_dEmissao)
        SRA->RA_NOMECMP := _cNomeCmp
        SRA->RA_MAE     := _cNomeMae
        SRA->RA_PAI     := _cNomePai
        SRA->RA_SEXO    := _cSexo

        SRA->(MsUnlock())

    For nY := 1 To Len(_aArray)

        _cFilial       := IIF(AllTrim(_aArray[nY][1]) == "RF_FILIAL"   , _aArray[nY][2] ,  _cFilial       ) 
        _cMat          := IIF(AllTrim(_aArray[nY][1]) == "RF_MAT"      , _aArray[nY][2] ,  _cMat          )
        _cPd           := IIF(AllTrim(_aArray[nY][1]) == "RF_PD"       , _aArray[nY][2] ,  _cPd           )
        _dDatabas      := IIF(AllTrim(_aArray[nY][1]) == "RF_DATABAS"  , _aArray[nY][2] ,  _dDatabas      )
        _dDataFim      := IIF(AllTrim(_aArray[nY][1]) == "RF_DATAFIM"  , _aArray[nY][2] ,  _dDataFim      )
        _nDiasdir      := IIF(AllTrim(_aArray[nY][1]) == "RF_DIASDIR"  , _aArray[nY][2] ,  _nDiasdir      )
        _nDfervat      := IIF(AllTrim(_aArray[nY][1]) == "RF_DFERVAT"  , _aArray[nY][2] ,  _nDfervat      )
        _nDferaat      := IIF(AllTrim(_aArray[nY][1]) == "RF_DFERAAT"  , _aArray[nY][2] ,  _nDferaat      )

        If  !Empty(_cFilial)     .AND.;
            !Empty(_cMat)        .AND.;
            !Empty(_cPd)         .AND.;
            !Empty(_dDatabas)    .AND.;
            !Empty(_dDataFim)    .AND.;
            !Empty(_nDiasdir)    .AND.;
            !Empty(_nDfervat)    .AND.;
            !Empty(_nDferaat)       
           
            RecLock("SRF", .T.)

                SRF->RF_FILIAL  :=  _cFilial 
                SRF->RF_MAT     := _cMat
                SRF->RF_PD      := _cPd
                SRF->RF_DATABAS := Stod(_dDatabas)
                SRF->RF_DATAFIM := Stod(_dDataFim)
                SRF->RF_DIASDIR := Val(_nDiasdir)
                SRF->RF_DFERVAT := Val(_nDfervat)
                SRF->RF_DFERAAT := Val(_nDferaat)
    
            SRF->(MsUnlock())

        EndIf

    Next 

    _cMsg += "Registro incluido com sucesso " 
   
Return(.T.)
