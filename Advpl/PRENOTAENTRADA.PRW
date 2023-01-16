#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE 'TOTVS.CH'
#INCLUDE'PROTHEUS.CH'
/**************************************************************************************************
{Protheus.doc} eMata140
@description	Execauto pre nota
@type   		WSRESTFUL	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		26/09/2022
@database		26/09/2022
@country		Brasil
@language		PT-BR
@obs			26/09/2022 - Controle de documentacao
@param			
@return		    Nil 				
*****************************************************************************************************/
User Function eMata140(oJson, _cDoc, _cSerie, _cFornece, _cLoja, _cCond , _dDataBase, _cEspecie,;
                        _cEst, _aItens, _cMsg )

Local _cFilC        := ""
Local _cItem        := ""
Local _cCod         := ""
Local _cUm          := ""
Local _nQuant       := 0
Local _nVunit       := 0
Local _nTotal       := 0
Local nY            := 0
Local aCabec        := {}
Local _aItensF1     := {}
Local aLinha        := {}
Local _lRet         := .F.
Private lMsErroAuto := .F.

    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" TABLES "SF1","SD1","SA1","SA2","SB1","SB2","SF4"

    fAltParam(.F.)

        aAdd(aCabec,{"F1_DOC"    , _cDoc     ,NIL})//Caracter 
        aAdd(aCabec,{"F1_SERIE"  , _cSerie   ,NIL})//Caracter
        aAdd(aCabec,{"F1_FORNECE", _cFornece ,NIL})//Caracter
        aAdd(aCabec,{"F1_LOJA"   , _cLoja    ,NIL})//Caracter
        aAdd(aCabec,{"F1_COND"   , _cCond    ,NIL})//Caracter
        aAdd(aCabec,{"F1_EMISSAO", Stod(_dDataBase),NIL})//Data
        aAdd(aCabec,{"F1_ESPECIE", _cEspecie ,NIL})//Caracter  
        aAdd(aCabec,{"F1_EST"    , _cEst     ,NIL})//Caracter

    For nY := 1 To Len(_aItens)

        _cFilC   := IIF(AllTrim(_aItens[nY][1]) == "D1_FILIAL" , _aItens[nY][2] , _cFilC  )    
        _cItem   := IIF(AllTrim(_aItens[nY][1]) == "D1_ITEM"   , _aItens[nY][2] , _cItem  )
        _cCod    := IIF(AllTrim(_aItens[nY][1]) == "D1_COD"    , _aItens[nY][2] , _cCod   )
        _cUm     := IIF(AllTrim(_aItens[nY][1]) == "D1_UM"     , _aItens[nY][2] , _cUm    )
        _nQuant  := IIF(AllTrim(_aItens[nY][1]) == "D1_QUANT"  , _aItens[nY][2] , _nQuant )
        _nVunit  := IIF(AllTrim(_aItens[nY][1]) == "D1_VUNIT"  , _aItens[nY][2] , _nVunit )  
        _nTotal  := IIF(AllTrim(_aItens[nY][1]) == "D1_TOTAL"  , _aItens[nY][2] , _nTotal )  

        If  !Empty(_cFilC)       .AND.;
            !Empty(_cItem)       .AND.;
            !Empty(_cCod)        .AND.;
            !Empty(_cUm)         .AND.;
            !Empty(_nQuant)      .AND.;
            !Empty(_nVunit)      .AND.;
            !Empty(_nTotal)       

            _aItensF1 := {}

            aAdd(_aItensF1,{"D1_FILIAL", _cFilC  ,NIL})//Caracter 
            aAdd(_aItensF1,{"D1_ITEM"  , _cItem  ,NIL})//Caracter 
            aAdd(_aItensF1,{"D1_COD"   , _cCod   ,NIL})//Caracter 
            aAdd(_aItensF1,{"D1_UM"    , _cUm    ,Nil})//Caracter
            aAdd(_aItensF1,{"D1_QUANT" , Val(_nQuant) ,Nil})//Numerico
            aAdd(_aItensF1,{"D1_VUNIT" , Val(_nVunit) ,Nil})//Numerico
            aAdd(_aItensF1,{"D1_TOTAL" , Val(_nTotal) ,Nil})//Numerico

            aAdd(aLinha,_aItensF1)

            _cFilC   := ""
            _cItem   := ""
            _cCod    := ""
            _cUm     := ""
            _nQuant  := 0
            _nVunit  := 0
            _nTotal  := 0
    
        EndIf 
    
    Next


    MSExecAuto({|x,y,z,a,b| MATA140(x,y,z,a,b)}, aCabec, aLinha, 3,,)

    If lMsErroAuto
        _cMsg := mostraerro("C:\TOTVS\producao\protheus_data\system", "error.log")
    Else
        _cMsg := "Incluindo com sucesso!"//Incluiu com sucesso
        _lRet := .T.
    EndIf

    fAltParam(.T.)


Return(_lRet)



Static Function fAltParam(_lTipo)

    PUTMV("MV_PCNFE", _lTipo)

Return
