@REM Inicialização do Programa:
    mode 62, 28
    @echo off
    goto Initialization

    :Menu
        title Menu_Principal - MINECRAFT SERVER
        color %theme%
        cls

        echo.
        echo  "+-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+  +-+-+-+-+-+-+"
        echo  "|M| |I| |N| |E| |C| |R| |A| |F| |T| |-|  |S|e|r|v|e|r|"
        echo  "+-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+  +-+-+-+-+-+-+"
        echo -------------------------- // ----------------------------
        echo     MENU
        echo         1   -   Start Minecraft Bedrock Server
        echo         2   -   Start Minecraft Java Server
        echo.
        echo         0   -   Close Minecraft Server Batch UI
        echo         C   -   Application Configurations
        echo.
        set /p SelectMenu=">> "
            if %SelectMenu% == 1 goto Bedrock_Server
            if %SelectMenu% == 2 goto Java_Server
            if %SelectMenu% == 0 goto SureExit
            if %SelectMenu% == c goto AppConfig
            msg * /time:5 Valor Invalido
            goto Menu

@REM UI de Finalização de Programa
    :SureExit
        Title Fechar?
        Color 04
        cls
        Echo Você tem Certeza que Deseja Fechar o Programa?
        Echo.
        Echo        "<y> sim, tenho!   <n> voltar"
        Echo.
        set /p Certeza=">> "
            if %Certeza% == y goto EXIT_UI
            if %Certeza% == n goto Menu
            msg * /time:2 Valor Invalido      
            goto SureExit

    :EXIT_UI 
        Title fechando...
        color 04
        cls
        echo "~~ Fechando Minecraft Server Batch UI ~~"
        pause /time:2
        exit

@REM Java UI
    :Java_Server
        title Minecraft Server - Java
        echo Redirecting Minecraft Java Server...
        cd Java
        pause
        if %javaoption% == enabled (
            if %javamemoryallocation% == "SM" goto EnableGUIS
            if %javamemoryallocation% == "1M" goto EnableGUI1M
            if %javamemoryallocation% == "2M" goto EnableGUI2M
            if %javamemoryallocation% == "4M" goto EnableGUI4M
        )
        if %javaoption% == disabled (
            if %javamemoryallocation% == "SM" goto DisableGUIS
            if %javamemoryallocation% == "1M" goto DisableGUI1M
            if %javamemoryallocation% == "2M" goto DisableGUI2M
            if %javamemoryallocation% == "4M" goto DisableGUI4M
        )
        

    :EnableGUIS
        java -jar server.jar
        echo pressione enter para sair do servidor...
        pause >nul
        cd ..
        goto Menu

    :DisableGUIS
        java -jar server.jar nogui
        echo pressione enter para sair do servidor...
        pause >nul
        cd ..
        goto Menu
        
    :EnableGUI1M
        java -Xmx1024M -Xms1024M -jar server.jar
        echo pressione enter para sair do servidor...
        pause >nul
        cd ..
        goto Menu

    :DisableGUI1M
        java -Xmx1024M -Xms1024M -jar server.jar nogui
        echo pressione enter para sair do servidor...
        pause >nul
        cd ..
        goto Menu

    :EnableGUI2M
        java -Xmx2048M -Xms2048M -jar server.jar
        echo pressione enter para sair do servidor...
        pause >nul
        cd ..
        goto Menu

    :DisableGUI2M
        java -Xmx2048M -Xms2048M -jar server.jar nogui
        echo pressione enter para sair do servidor...
        pause >nul
        cd ..
        goto Menu

    :EnableGUI4M
        java -Xmx4096M -Xms4096M -jar server.jar
        echo pressione enter para sair do servidor...
        pause >nul
        cd ..
        goto Menu

    :DisableGUI4M
        java -Xmx4096M -Xms4096M -jar server.jar nogui
        echo pressione enter para sair do servidor...
        pause >nul
        cd ..
        goto Menu

@REM Bedrock UI
    :Bedrock_Server
        title Minecraft Server - Bedrock
        echo Redirecting Minecraft Bedrock Server...
        cd Bedrock
        start bedrock_server.exe
        pause
        cd ..
        goto Menu

@REM Application Configuration
    :Initialization REM Aqui ficam todas as dependências que o programa precisa para funcionar por padrão...
        if exist "%cd%\Config\theme.config" ( 
            echo "Carregando Tema..." ) else ( 
                echo "[theme.config] ausente, Criando arquivo como Padrao..."
                echo 01 > "%cd%\Config\theme.config"
                echo "Concluido")
        set /p theme=<"%cd%\Config\theme.config"
        timeout /t 1 /nobreak >nul
        if exist "%cd%\Config\javaoption.config" ( 
            echo "Carregando Configuracao de GUI..." ) else ( 
                echo "[javaoption.config] ausente, Criando arquivo como Padrao..."
                echo enabled > "%cd%\Config\javaoption.config"
                echo "Concluido")
        set /p javaoption=<"%cd%\Config\javaoption.config"
        timeout /t 1 /nobreak >nul
        if exist "%cd%\Config\javamemoryallocation.config" ( 
            echo "Carregando Configuracoes Java..." ) else ( 
                echo "[javamemoryallocation.config] ausente, Criando arquivo como Padrao..."
                echo SM > "%cd%\Config\javamemoryallocation.config"
                echo "Concluido")
        set /p javamemoryallocation=<"%cd%\Config\javamemoryallocation.config"
        timeout /t 1 /nobreak >nul
        echo "Carregando Presets..."
        timeout /t 3 /nobreak >nul
        if %javamemoryallocation% == SM set MemAllocVis=Desativado
        if %javamemoryallocation% == 1M set MemAllocVis=1024M
        if %javamemoryallocation% == 2M set MemAllocVis=2048M
        if %javamemoryallocation% == 4M set MemAllocVis=4096M
        
        echo "<< Concluido! >>"
        pause >nul
        goto Menu

    :AppConfig
        @REM  "Aqui ficará o espaço necessário para a ui principal"
        title Minecraft Server - Configuracoes
        color %theme%
        cls
        echo.
        echo     "<<  Selecione a Configuração que deseja alterar  >>"
        echo.
        echo           1  -  Tema
        echo           2  -  GUI Minecraft Server Java
        echo           3  -  Alocacao de Memoria para Java
        echo.
        echo           0  -  Voltar
        @REM  "___________________________________________________"

        set /p configchange=">> "
            if %configchange% == 1 goto ThemeChangeUI
            if %configchange% == 2 goto GuiChangeUI
            if %configchange% == 3 goto MemAllocChangeUI
            if %configchange% == 0 goto Menu
            msg * /time:2 Configuracao nao encontrada

@REM Temas
    :ThemeChangeUI 
        @REM  "Aqui ficará o espaço necessário para a ui principal"
        title Configurações - Mudar Tema
        color %theme%
        cls

        echo.
        echo    "<< Escolha um dos Temas Abaixo >>"
        echo.
        echo          1  -  Padrao
        echo          2  -  Tema Claro
        echo          3  -  Tema Escuro
        echo          4  -  Tema Aquatico
        echo          5  -  Tema OverWorld
        echo          6  -  Tema Nether
        echo          7  -  Tema The End
        echo.
        echo          0  -  Voltar
        @REM  "___________________________________________________"

        set /p themechange=">> "
            if %themechange% == 1 goto SetThemeStandart
            if %themechange% == 2 goto SetThemeLight
            if %themechange% == 3 goto SetThemeDark
            if %themechange% == 4 goto SetThemeAqua
            if %themechange% == 5 goto SetThemeOverWorld
            if %themechange% == 6 goto SetThemeNether
            if %themechange% == 7 goto SetThemeTheEnd
            if %themechange% == 0 goto AppConfig
            msg * /time:1 TEMA INVALIDO

    :SetThemeStandart
        del "%cd%\Config\theme.config"
        echo 0f > "%cd%\Config\theme.config"
        set theme=0f
        goto ThemeChangeUI

    :SetThemeLight
    @echo on
        del "%cd%\Config\theme.config"
        echo f8 > "%cd%\Config\theme.config"
        set theme=f8
        @echo off
        goto ThemeChangeUI

    :SetThemeDark
        del "%cd%\Config\theme.config"
        echo 08 > "%cd%\Config\theme.config"
        set theme=08
        goto ThemeChangeUI

    :SetThemeAqua
        del "%cd%\Config\theme.config"
        echo b1 > "%cd%\Config\theme.config"
        set theme=b1
        goto ThemeChangeUI

    :SetThemeOverWorld
        del "%cd%\Config\theme.config"
        echo 02 > "%cd%\Config\theme.config"
        set theme=02
        goto ThemeChangeUI

    :SetThemeNether
        del "%cd%\Config\theme.config"
        echo 4e > "%cd%\Config\theme.config"
        set theme=4e
        goto ThemeChangeUI

    :SetThemeTheEnd
        del "%cd%\Config\theme.config"
        echo e0 > "%cd%\Config\theme.config"
        set theme=e0
        goto ThemeChangeUI

@REM Alteração de GUI
    :GuiChangeUI
        @REM  "Aqui ficará o espaço necessário para a ui principal"
        title Configuracoes - Mudar Visibilidade de GUI
        color %theme%
        cls
        echo.
        echo           Ativar/Desativar GUI do Servidor Java
        echo                  Gui : %javaoption%
        echo.
        echo                       alterar?
        echo.
        echo            "<y> sim, alterar!   <n> voltar"
        echo.
        @REM  "___________________________________________________"
        set /p guialter=">> "
            if %javaoption% == enabled ( if %guialter% == y ( goto GuiDisable ) else if %guialter% == n ( goto AppConfig ) else ( msg * /time:1 VALOR INVALIDO ) )
            if %javaoption% == disabled ( if %guialter% == y ( goto GuiEnable ) else if %guialter% == n ( goto AppConfig ) else ( msg * /time:1 VALOR INVALIDO ) )
            if %guialter% == n goto AppConfig
            msg * /time:1 VALOR INVALIDO
            goto GuiChangeUI

    :GuiEnable
        del "%cd%\Config\javaoption.config"
        echo enabled > "%cd%\Config\javaoption.config"
        set javaoption=enabled
        echo. 
        echo                 "<<  Gui Alterada  >>"
        echo.
        pause
        goto GuiChangeUI

    :GuiDisable
        del "%cd%\Config\javaoption.config"
        echo disabled > "%cd%\Config\javaoption.config"
        set javaoption=disabled
        echo. 
        echo                 "<<  Gui Alterada  >>"
        echo.
        pause
        goto GuiChangeUI

@REM Alteração de Alocação de Memória
    :MemAllocChangeUI
        @REM  "Aqui ficará o espaço necessário para a ui principal"
        title Configuracoes - Mudar Alocacao de Memoria
        color %theme%
        cls
        echo.
        echo           Mudar Alocacao de UI do Servidor Java
        echo           Alocacao de Memoria : %MemAllocVis%
        echo.
        echo                       alterar?
        echo.
        echo                  1  -  Desativar
        echo                  2  -  1024M
        echo                  3  -  2048M
        echo                  4  -  4096M
        echo.
        echo                  0  -  Voltar
        echo.
        @REM  "___________________________________________________"
        set /p alteralloc=">> "
            if %alteralloc% == 1 goto StandartMemAlloc
            if %alteralloc% == 2 goto 1024MemAlloc
            if %alteralloc% == 3 goto 2048MemAlloc
            if %alteralloc% == 4 goto 4096MemAlloc
            if %alteralloc% == 0 goto AppConfig
            msg * /time:1 VALOR INVALIDO
            goto MemAllocChangeUI

    :StandartMemAlloc
        del "%cd%\Config\javamemoryallocation.config"
        echo SM > "%cd%\Config\javamemoryallocation.config"
        set javamemoryallocation=SM
        set MemAllocVis=Desativado
        echo. 
        echo         "<<  Alocacao de Memoria Alterada  >>"
        echo.
        pause
        goto MemAllocChangeUI

    :1024MemAlloc
        del "%cd%\Config\javamemoryallocation.config"
        echo 1M > "%cd%\Config\javamemoryallocation.config"
        set javamemoryallocation=1M
        set MemAllocVis=1024M
        echo. 
        echo         "<<  Alocacao de Memoria Alterada  >>"
        echo.
        pause
        goto MemAllocChangeUI

    :2048MemAlloc
        del "%cd%\Config\javamemoryallocation.config"
        echo 2M > "%cd%\Config\javamemoryallocation.config"
        set javamemoryallocation=2M
        set MemAllocVis=2048M
        echo. 
        echo         "<<  Alocacao de Memoria Alterada  >>"
        echo.
        pause
        goto MemAllocChangeUI

    :4096MemAlloc
        del "%cd%\Config\javamemoryallocation.config"
        echo 4M > "%cd%\Config\javamemoryallocation.config"
        set javamemoryallocation=4M
        set MemAllocVis=4096M
        echo. 
        echo         "<<  Alocacao de Memoria Alterada  >>"
        echo.
        pause
        goto MemAllocChangeUI