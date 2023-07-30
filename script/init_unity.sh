# Author: newblity523@gmail.com
# Date: 2023-07-30 T16:29
# Summary: init unity3D project
projectDir=$(realpath $1)

if [ ! -d "$projectDir" ]; then
    echo "Error: $projectDir not exist."
    exit 1
fi

echo "Init unity3D project in $projectDir"

toolScriptDir=$(realpath $(dirname $(realpath $0))/../)

prefabDir="Prefab"
scriptDir="Script"
thirdPartDir="ThirdPart"
basicDirs=($prefabDir $scriptDir $thirdPartDir)

echo "Create basic dirs:"
for dir in "${basicDirs[@]}"; do
    echo "- $dir"
    if [ ! -d "$projectDir/$dir" ]; then
        mkdir "$projectDir/$dir"
    fi
done

echo ""
echo "Plugins:"
# tween
read -p "Add DOTween? (y/n) " addTween
if [ "$addTween" == "y" ]; then
    echo "-adding tween"
    tweenDir="Tween"
    if [ ! -d "$projectDir/$thirdPartDir/$tweenDir" ]; then
        mkdir "$projectDir/$thirdPartDir/$tweenDir"
    fi
    # cp -r ./tween/* "$projectDir/$thirdPartDir/$tweenDir"
fi

read -p "Add XLua? (y/n) " addXlua
if [ "$addXlua" == "y" ]; then
    echo "-adding xlua"
    xluaDir="XLua"
    if [ ! -d "$projectDir/$thirdPartDir/$xluaDir" ]; then
        mkdir "$projectDir/$thirdPartDir/$xluaDir"
    fi
    # cp -r ./xlua/* "$projectDir/$thirdPartDir/$xluaDir"
fi

# IDE config
read -p "Using VSCode? (y/n) " useVSCode
useVSCode="y"
if [ "$useVSCode" == "y" ]; then
    echo "-initing vscode config"
    if [ ! -d "$projectDir/.vscode" ]; then
        mkdir "$projectDir/.vscode"
        cp "$toolScriptDir/vscode/settings_unity_common.json" "$projectDir/.vscode/settings.json"
    fi
fi

# use svn or git
read -p "Verson control: git or svn? (default: git) " versionControl
versionControl="git"
if [ "$versionControl" == "git" ]; then
    lastDir="$PWD"
    cd $projectDir
    isGit=$(git rev-parse --is-inside-work-tree)
    cd $lastDir
    if [ ! "$isGit" == "true" ]; then
        echo "\tInit git"
        touch $projectDir/.gitignore
        touch $projectDir/.gitmodules

        git init $projectDir
    fi
fi

if [ "$versionControl" == "svn" ]; then
    echo "Not support svn yet."
fi

echo "Done."
