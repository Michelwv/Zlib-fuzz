Steps to use older version:

Download tar.gz from zlib.net/fossils/
Extract and copy to fuzzing directory
Run:
``` cd ~/Fuzzing/old_zlib ```
``` make clean 2>/dev/null ```
``` CC=afl-clang-fast CFLAGS="-O2" ./configure ```
``` make ```
``` afl-clang-fast zpipe.c ./old_zlib/libz.a -o zpipe_afl_old ```

Can verify that it uses the old version by adding

``` printf("Compiled with zlib version: %s\n", ZLIB_VERSION); ```
``` printf("Linked zlib runtime version: %s\n", zlibVersion()); ```

to the zpipe main function and running 
``` ./zpipe_afl_old -d < seeds/hello_world.gz > /dev/null ```
and making sure the output has the correct version

Then
``` afl-fuzz -i seeds -o out_old -- ./zpipe_afl_old -d ```
should fuzz using the old version
