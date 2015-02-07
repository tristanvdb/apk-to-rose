
## Usage

Install:
```bash
git clone git@github.com:tristanvdb/apk-to-rose.git
cd apk-to-rose

./scripts/install.sh $BOOST_HOME
```

Test:
```bash
source apk-to-rose.rc
make -C examples
```

## Dependencies

 * [APK2JAVA](http://github.com/tristanvdb/apk-to-java) : resolved automatically
 * gcc :   4.4.7
 * boost : 1.45.0

## TODO

### Work on CFG

Need to see what kind of CFG we can get from ROSE for JAVA.

### Problem using ROSE on decompiled files

Some decompiled files are can not be parsed by ROSE.
 * while statement without a block *\{ ... \}* seems to cause some issues
 * break statement refering to labels are sometime invalid

About Java labels and break statements: [http://stackoverflow.com/a/14960484](http://stackoverflow.com/a/14960484).

