#INCLUDE 'TOTVS.CH'
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TBICONN.CH'

/**************************************************************************************************
{Protheus.doc} TRANSF1
@description	Funcao para encerrar a cotacao
@type   		User Function	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		28/10/2022
@database		28/10/2022
@country		Brasil
@language		PT-BR
@obs			28/10/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User Function TRANSF1(oJson, _aArray, _cMsg)

Local _cFilial          := ""
Local _cMatricula       := ""
Local _cDepto           := ""
Local _cCc              := ""
Local _dDataTransf      := ""
Local _cFilialPadrao    := ""
Local _cCodMat          := ""
Local aAutoItens        := {}
Local aCampos           := {}
Local dDataTransf       :=  CtoD("//")
Local nY                := 0
Private lMsErroAuto     := .F.

    PREPARE ENVIRONMENT EMPRESA "99" FILIAL "0101" MODULO "GPE"

    ConOut(Repl("-",80))
    ConOut("Inicio: "+Time())
    ConOut(PadC("Rotina Automatica Transferencia de funcionarios - SRA",80))


    For nY := 1 To Len(_aArray)

        _cFilial         := IIF(AllTrim(_aArray[nY][1]) == "RA_FILIAL"    , _aArray[nY][2] ,  _cFilial        )
        _cMatricula      := IIF(AllTrim(_aArray[nY][1]) == "RA_MAT"       , _aArray[nY][2] ,  _cMatricula     )
        _cDepto          := IIF(AllTrim(_aArray[nY][1]) == "RA_DEPTO"     , _aArray[nY][2] ,  _cDepto         )
        _cCc             := IIF(AllTrim(_aArray[nY][1]) == "RA_CC"        , _aArray[nY][2] ,  _cCc            )
        _dDataTransf     := IIF(AllTrim(_aArray[nY][1]) == "DataTransf"   , _aArray[nY][2] ,  _dDataTransf    )
        _cFilialPadrao   := IIF(AllTrim(_aArray[nY][1]) == "FilialPadrao" , _aArray[nY][2] ,  _cFilialPadrao  )
        _cCodMat         := IIF(AllTrim(_aArray[nY][1]) == "CodMat"       , _aArray[nY][2] ,  _cCodMat        )

        
        If  !Empty(_cFilial)        .AND.;
            !Empty(_cMatricula)     .AND.;
            !Empty(_cDepto)         .AND.;
            !Empty(_cCc)            .AND.;
            !Empty(_dDataTransf)    .AND.;
            !Empty(_cFilialPadrao)  .AND.;
            !Empty(_cCodMat) 
            
            dDataTransf   := StoD(_dDataTransf)

            fLocalizReg(@_cMatricula,@_cFilial)

            aCampos := {}   
            aAdd(aCampos,{"RA_FILIAL", _cFilial                  })
            aAdd(aCampos,{"RA_MAT"   , StrZero(_cMatricula, 6)   })
            aAdd(aCampos,{"RA_DEPTO" , _cDepto                   })
            aAdd(aCampos,{"RA_CC"    , _cCc                      })
            aAdd(aAutoItens,{_cFilialPadrao  , _cCodMat,  aCampos}) 
    
            //chamada ExecAuto
            MSExecAuto( {|x,y,z,w| GPEA180(x,y,z,w)}, 6, aAutoItens, dDataTransf, .T. )

            If !lMsErroAuto

                _cMsg += " {Transferencia: "+_cMatricula + "}," + CRLF 

                _cFilial         := ""
                _cMatricula      := ""
                _cDepto          := ""
                _cCc             := ""
                _dDataTransf     := ""
                _cFilialPadrao   := ""
                _cCodMat         := ""
                aAutoItens       := {} 

            Else

                If !IsBlind()
                   _cMsg += MostraErro('Null')
                    Else
                    _cMsg += MostraErro("C:\TOTVS\producao\protheus_data\system", "error.log") //caso acionada
                    Return(.F.)
                EndIf  

            EndIf

        EndIf   
    
    Next

    _cMsg :=  SubStr(AllTrim(_cMsg), 1, RAT(",",_cMsg)-1) + CRLF

    ConOut("Fim : "+Time())
    ConOut(Repl("-",80))    
 
    RESET ENVIRONMENT

Return(.T.) 
/**************************************************************************************************
{Protheus.doc} TRANSF1
@description	Funcao para chama proximo codigo da sra 
@type   		User Function	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		28/10/2022
@database		28/10/2022
@country		Brasil
@language		PT-BR
@obs			28/10/2022 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Static Function fLocalizReg(_cMatricula,_cFilial)

Local cQry  := ""
Local _cAlias := GetNextAlias() 

    cQry := " SELECT "
    cQry += " MAX(RA_MAT) as RA_MAT "
    cQry += " FROM " + RetSqlName("SRA") + " RA"
    cQry += " WHERE "
    cQry += " RA_FILIAL = '"+AllTrim(_cFilial)+"'  "

    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,cQry) , _cAlias , .T. , .F. ) 

    _cMatricula := Val((_cAlias)->RA_MAT ) + 1

Return 
