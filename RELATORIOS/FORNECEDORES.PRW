#Include "Totvs.ch"
#Include "Protheus.ch"

/**************************************************************************************************
{Protheus.doc} fFornece1
@description	Relatório de compras por fornecedores comprados na localidade do contrato
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		09/08/2022
@database		09/08/2022
@country		Brasil
@language		PT-BR
@obs			09/08/2022 - Controle de documentacao
@return		    Nil
*****************************************************************************************************/

User Function fFornece1()

Local _aCabec     := {}
Local _aDados     := {} 
Local _aParam     := {}
Local _aParRet    := {}
Local _cNomArq    := "RelProd_"+ RetCodUsr() + StrTran( Time() , ":" , "" ) +".xls"
Local _cAba       := "SC7"
Local _cTabela    := "Compras por fornecedores" 
Local _cCodDe	  := Space(TamSx3("C7_NUM")    [01])
Local _cFornecDe  := Space(TamSx3("A2_COD")    [01])
Local _cFornecate := Space(TamSx3("A2_COD")    [01])
Local _cFilial    := Space(TamSx3("C7_FILIAL") [01]) 
Local _cPath      := Space(200)                        
Local _nI         := 0
Local _oExcel     := Nil
Local _oMsExcel   := Nil

    If ApOleClient( "MSExcel" ) 

        AADD( _aParam , { 1 , "  Pedido.:"         , _cCodDe      , "" ,""    ,"SC7"  ,""   , 090 , .F. })// MV_PAR01
        AADD( _aParam , { 1 , "  Fornecedor De.:"  , _cFornecDe   , "" ,""    ,"SA2"  ,""   , 050 , .F. })// MV_PAR02
        AADD( _aParam , { 1 , "  Fornecedor Ate.:" , _cFornecate  , "" ,""    ,"SA2"  ,""   , 050 , .F. })// MV_PAR03
        AADD( _aParam , { 1 , "  Filial.:"         , _cFilial     , "" ,""    ,"SM0"  ,""   , 050 , .F. })// MV_PAR04
        AADD( _aParam , { 6 , "  Destino"	       , _cPath       , "" , ".T.", ".T." , 060 , .T. , "" , "C:\" , GETF_LOCALHARD + GETF_RETDIRECTORY } )// MV_PAR05


        For _nI := 1 To Len( _aParam )
            AADD( _aParRet , _aParam[_nI][03] )
        Next _nI
	
        If Parambox( _aParam , 'Extracao em Planilha ' , @_aParRet ,,, .F. ,,,,, .F. , .F. ) 

            FWMsgRun( , {|| _aCabec := fCabc()           } ,, "Aguarde! Inicializando a estrutura do relatorio..." )
            FWMsgRun( , {|| _aDados := fQuery(  _aCabec ) } ,, "Aguarde! Selecionando registros..."                )
            _cPath := AllTrim(MV_PAR05)

            // Instancia Objeto
            _oExcel  := FWMSExcel():New()
        
            // Criação de nova aba
            _oExcel:AddworkSheet( _cAba )

            // Criaação de tabela
            _oExcel:AddTable( _cAba , _cTabela )

            // Criação de colunas
            For _nI := 1 To Len( _aCabec )
                _oExcel:AddColumn( _cAba , _cTabela , _aCabec[_nI][02] , _aCabec[_nI][05] , 1 , .F. )
            Next _nI

            For _nI := 1 To Len( _aDados )

                // Criação de Linhas
                _oExcel:AddRow( _cAba , _cTabela , _aDados[_nI] )

            Next _nI

            If !Empty( _oExcel:aWorkSheet )

                _oExcel:Activate()
                _oExcel:GetXMLFile( _cNomArq )
        
                FWMsgRun( , {|| CpyS2T( "\SYSTEM\"+ _cNomArq , _cPath ) } ,, "Aguarde! Copiando arquivo..." )

                _oMsExcel := MsExcel():New()
                _oMsExcel:WorkBooks:Open( _cPath + _cNomArq ) // Abre a planilha
                _oMsExcel:SetVisible(.T.) // Exportar planilha do excel usando FWMsExcel 
                _oMsExcel:Destroy()

            EndIf
		
        Else
            MsgStop( "Execução cancelada pelo usuario" , "Atenção!" )
        EndIf
	
    Else
        MsgStop( "Microsoft Excel não instalado no computador local!" , "Atenção!" )
	EndIf

Return()

/**************************************************************************************************
{Protheus.doc} fQuery
@description	Funcao para gerar o cabecalho do relatorio
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		09/08/2022
@database		09/08/2022
@country		Brasil
@language		PT-BR
@obs			09/08/2022 - Controle de documentacao
@param			_aCabec, array
@return		    array
*****************************************************************************************************/
Static Function fCabc()

Local _aRet     := {}

    AADD( _aRet , { "C7_NUM"        , "NUMERO"            , "C" , "" , 2 } )
    AADD( _aRet , { "C7_FORNECE"    , "FORNECEDO"         , "C" , "" , 2 } )
    AADD( _aRet , { "C7_IPI"        , "Aliq.IPI"          , "N" , "" , 2 } )
    AADD( _aRet , { "C7_DESC"       , "DESCRIÇÃO"         , "C" , "" , 2 } )
    AADD( _aRet , { "C7_FILIAL"     , "FILIAL"            , "C" , "" , 2 } )
    AADD( _aRet , { "C7_PRODUTO"    , "PRODUTO"           , "C" , "" , 2 } )
    AADD( _aRet , { "C7_ITEM"       , "ITEM"              , "C" , "" , 2 } )
    AADD( _aRet , { "C7_COND"       , "COND.PAGTO"        , "C" , "" , 1 } )
    AADD( _aRet , { "A2_END"        , "ENDEREÇO"          , "C" , "" , 1 } )
    AADD( _aRet , { "A2_NREDUZ"     , "N FANTASIA"        , "C" , "" , 1 } )
    AADD( _aRet , { "A2_COD"        , "CODIGO"            , "C" , "" , 1 } )
    AADD( _aRet , { "A2_CONTA"      , "CONTABIL"          , "C" , "" , 1 } )
    AADD( _aRet , { "A2_NOME"       , "NOME"              , "C" , "" , 1 } )
    
Return( _aRet )

/**************************************************************************************************
{Protheus.doc} fQuery
@description	Funcao para gerar aquery de produtos
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		09/08/2022
@database		09/08/2022
@country		Brasil
@language		PT-BR
@obs			09/08/2022 - Controle de documentacao
@param			_aCabec, array
@return		    array
*****************************************************************************************************/
Static Function fQuery( _aCabec )

Local _aRet     := {}
Local _cQuery   := ""
Local _cAlias   := GetNextAlias()

    _cQuery := " SELECT       "
    _cQuery += " C7_NUM,      "
    _cQuery += " C7_FORNECE,  "
    _cQuery += " C7_IPI,      "
    _cQuery += " C7_DESC,     "
    _cQuery += " C7_FILIAL,   "
    _cQuery += " C7_PRODUTO,  " 
    _cQuery += " C7_ITEM,     "
    _cQuery += " C7_COND,     "
    _cQuery += " A2_END,      "
    _cQuery += " A2_NREDUZ,   "
    _cQuery += " A2_COD,      "  
    _cQuery += " A2_CONTA,    "
    _cQuery += " A2_NOME      "
    _cQuery += " FROM " + RetSqlName("SC7") + " C7"
    _cQuery += " INNER JOIN "+ RetSqlName("SA2") + " AS SA2 ON "+ RetSqlDel("SA2") +" AND A2_COD = C7_FORNECE "
    _cQuery += " WHERE "
    _cQuery += " C7.D_E_L_E_T_ = '' "

    If !Empty(MV_PAR01) // Mostra se ela esta vazia 
        _cQuery += " AND C7_NUM =  '"+MV_PAR01+"'"
    EndIf

   If !Empty(MV_PAR02) .AND. !Empty(MV_PAR03)
        _cQuery += " AND C7_FORNECE BETWEEN  '"+MV_PAR02+"' AND '"+MV_PAR03+"' "
    EndIf

    If !Empty(MV_PAR04)
        _cQuery += "AND C7_FILIAL = '"+MV_PAR04+"'"
    EndIf  

     //porta Alias
    If Select( _cAlias ) > 0
        (_cAlias)->( DBCloseArea() )//fecha o alias 
    EndIf
                                                                 
    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQuery) , _cAlias , .T. , .F. ) 

    DBSelectArea(_cAlias)
    (_cAlias)->( DBGoTop() )
    While (_cAlias)->( !Eof() )

     AADD( _aRet ,{ fDefineType( (_cAlias)->C7_NUM     , _aCabec , 01 )  ,;
                    fDefineType( (_cAlias)->C7_FORNECE , _aCabec , 02 )  ,;
                    fDefineType( (_cAlias)->C7_IPI     , _aCabec , 03 )  ,;
                    fDefineType( (_cAlias)->C7_DESC    , _aCabec , 04 )  ,;
                    fDefineType( (_cAlias)->C7_FILIAL  , _aCabec , 05 )  ,;
                    fDefineType( (_cAlias)->C7_PRODUTO , _aCabec , 06 )  ,;
                    fDefineType( (_cAlias)->C7_ITEM    , _aCabec , 07 )  ,;
                    fDefineType( (_cAlias)->C7_COND    , _aCabec , 08 )  ,;
                    fDefineType( (_cAlias)->A2_END     , _aCabec , 09 )  ,;
                    fDefineType( (_cAlias)->A2_NREDUZ  , _aCabec , 10 )  ,;
                    fDefineType( (_cAlias)->A2_COD     , _aCabec , 11 )  ,;
                    fDefineType( (_cAlias)->A2_NOME    , _aCabec , 12 )  ,;
                    fDefineType( (_cAlias)->A2_CONTA   , _aCabec , 13 )  })
                                 

            (_cAlias)->( DBSkip() )
    EndDo

Return( _aRet )

/**************************************************************************************************
{Protheus.doc} fDefineType
@description	Funcao para definir o valor de cada campo
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		09/08/2022
@database		09/08/2022
@country		Brasil
@language		PT-BR
@obs			09/08/2022 - Controle de documentacao
@param			_xValor, String
@param			_aCabec, array
@param          _nPos, Numeric
@return		    Type
*****************************************************************************************************/
Static Function fDefineType( _xValor , _aCabec , _nPos )

Local _xRet := NIL

    Do Case
        Case _aCabec[_nPos][03] == "C" ; _xRet := AllTrim(    _xValor )//caracter
        Case _aCabec[_nPos][03] == "D" ; _xRet := DTOC( STOD( _xValor ) )//data
        Case _aCabec[_nPos][03] == "N" ; _xRet := Transform(  _xValor , _aCabec[_nPos][04] )//numero
    EndCase

Return( _xRet )
