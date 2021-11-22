module CityHash
  VERSION = "0.1.0"

  # 静态链接直接链接指定目录，动态链接忽略。
  @[Link(ldflags: "-L#{__DIR__}/../cityhash/src/.libs -lcityhash")]
  lib Lib
    # REMARK: No extern "C" symbol names.

    # _Z10CityHash32PKcm
    # _Z10CityHash64PKcm
    # _Z11CityHash128PKcm
    # _Z18CityHash64WithSeedPKcmm
    # _Z19CityHash128WithSeedPKcmSt4pairImmE
    # _Z19CityHash64WithSeedsPKcmmm
    # _ZL12HashLen0to16PKcms

    # Hash function for a byte array.  Most useful in 32-bit binaries.
    fun CityHash32 = _Z10CityHash32PKcm(buf : LibC::Char*, len : LibC::SizeT) : UInt32

    # Hash function for a byte array.
    fun CityHash64 = _Z10CityHash64PKcm(buf : LibC::Char*, len : LibC::SizeT) : UInt64

    # Hash function for a byte array.
    fun CityHash128 = _Z11CityHash128PKcm(s : LibC::Char*, len : LibC::SizeT) : UInt128

    # Hash function for a byte array.  For convenience, a 64-bit seed is also hashed into the result.
    fun CityHash64WithSeed = _Z18CityHash64WithSeedPKcmm(buf : LibC::Char*, len : LibC::SizeT, seed : UInt64) : UInt64

    # Hash function for a byte array.  For convenience, a 128-bit seed is also hashed into the result.
    fun CityHash128WithSeed = _Z19CityHash128WithSeedPKcmSt4pairImmE(s : LibC::Char*, len : LibC::SizeT, seed : UInt128) : UInt128

    # Hash function for a byte array.  For convenience, two seeds are also hashed into the result.
    fun CityHash64WithSeeds = _Z19CityHash64WithSeedsPKcmmm(buf : LibC::Char*, len : LibC::SizeT, seed0 : UInt64, seed1 : UInt64) : UInt64
  end

  extend self

  def hash32(bytes : Bytes)
    Lib.CityHash32(bytes, bytes.size)
  end

  def hash32(str : String)
    hash32(str.to_slice)
  end

  def hash64(bytes : Bytes)
    Lib.CityHash64(bytes, bytes.size)
  end

  def hash64(str : String)
    hash64(str.to_slice)
  end

  def hash128(bytes : Bytes, swap : Bool = false)
    result = Lib.CityHash128(bytes, bytes.size)
    pointerof(result).as(UInt64*).swap(0, 1) if swap
    result
  end

  def hash128(str : String, swap : Bool = false)
    hash128(str.to_slice, swap)
  end
end
