#Include 'Protheus.ch'
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH" 

/**************************************************************************************************
{Protheus.doc} freclock
@description	Funcao para encerrar a cotacao
@type   		User Function	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		24/10/2022
@database		24/10/2022
@country		Brasil
@language		PT-BR
@obs			24/10/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User Function freclock(oJson,_aArray, _cMsg)

Local _cFilial      := ""
Local _cDocumento   := ""
Local _cSerie       := ""
Local _cForncecedor := ""
Local _cLoja        := ""
Local _cItemnf      := ""
Local _cItem        := ""
Local _nPerc        := 0
Local _cCc          := ""
Local _nCusto       := 0
Local nY            := 0

    For nY := 1 To Len(_aArray)

        _cFilial       := IIF(AllTrim(_aArray[nY][1]) == "DE_FILIAL"  , _aArray[nY][2] ,  _cFilial     ) 
        _cDocumento    := IIF(AllTrim(_aArray[nY][1]) == "DE_DOC"     , _aArray[nY][2] , _cDocumento   )
        _cSerie        := IIF(AllTrim(_aArray[nY][1]) == "DE_SERIE"   , _aArray[nY][2] ,  _cSerie      )
        _cForncecedor  := IIF(AllTrim(_aArray[nY][1]) == "DE_FORNECE" , _aArray[nY][2] , _cForncecedor )
        _cLoja         := IIF(AllTrim(_aArray[nY][1]) == "DE_LOJA"    , _aArray[nY][2] ,  _cLoja       )
        _cItemnf       := IIF(AllTrim(_aArray[nY][1]) == "DE_ITEMNF"  , _aArray[nY][2] ,  _cItemnf     )
        _cItem         := IIF(AllTrim(_aArray[nY][1]) == "DE_ITEM"    , _aArray[nY][2] ,  _cItem       )
        _nPerc         := IIF(AllTrim(_aArray[nY][1]) == "DE_PERC"    , _aArray[nY][2] ,  _nPerc       )
        _cCc           := IIF(AllTrim(_aArray[nY][1]) == "DE_CC"      , _aArray[nY][2] ,  _cCc         )
        _nCusto        := IIF(AllTrim(_aArray[nY][1]) == "DE_CUSTO1"  , _aArray[nY][2] ,  _nCusto      )

        If  !Empty(_cFilial)          .AND.;
            !Empty(_cDocumento)       .AND.;
            !Empty(_cSerie)           .AND.;
            !Empty(_cForncecedor)     .AND.;
            !Empty(_cLoja)            .AND.;
            !Empty(_cItemnf)          .AND.;
            !Empty(_cItem)            .AND.;
            !Empty(_nPerc)            .AND.;
            !Empty(_cCc)              .AND.;
            !Empty(_nCusto)    

        
            Reclock("SDE", .T.)

            SDE->DE_FILIAL      := _cFilial
            SDE->DE_DOC         := _cDocumento
            SDE->DE_SERIE       := _cSerie
            SDE->DE_FORNECE     := _cForncecedor
            SDE->DE_LOJA        := _cLoja
            SDE->DE_ITEMNF      := _cItemnf
            SDE->DE_ITEM        := _cItem
            SDE->DE_PERC        := Val(_nPerc)
            SDE->DE_CC          := _cCc
            SDE->DE_CUSTO1      := Val(_nCusto)

            _cFilial      := ""
            _cDocumento   := ""
            _cSerie       := ""
            _cForncecedor := ""
            _cLoja        := ""
            _cItemnf      := ""
            _cItem        := ""
            _nPerc        := 0
            _cCc          := ""
            _nCusto       := 0

            SDE->(MsUnlock())
        EndIf

    Next

    _cMsg := "Numero do documento nao existe na SD1 " + _cMsg
    _lRet := .F.

Return(_lRet)
