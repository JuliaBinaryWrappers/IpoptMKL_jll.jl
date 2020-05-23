# Autogenerated wrapper script for IpoptMKL_jll for x86_64-apple-darwin14-libgfortran5-cxx03
export amplexe, libipopt

using ASL_jll
using MKL_jll
using CompilerSupportLibraries_jll
## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "DYLD_FALLBACK_LIBRARY_PATH"
LIBPATH_default = "~/lib:/usr/local/lib:/lib:/usr/lib"

# Relative path to `amplexe`
const amplexe_splitpath = ["bin", "ipopt"]

# This will be filled out by __init__() for all products, as it must be done at runtime
amplexe_path = ""

# amplexe-specific global declaration
function amplexe(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(PATH, ':', ENV["PATH"])
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        LIBPATH_base = get(ENV, LIBPATH_env, expanduser(LIBPATH_default))
        if !isempty(LIBPATH_base)
            env_mapping[LIBPATH_env] = string(LIBPATH, ':', LIBPATH_base)
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(amplexe_path)
    end
end


# Relative path to `libipopt`
const libipopt_splitpath = ["lib", "libipopt.3.dylib"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libipopt_path = ""

# libipopt-specific global declaration
# This will be filled out by __init__()
libipopt_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libipopt = "@rpath/libipopt.3.dylib"


"""
Open all libraries
"""
function __init__()
    global artifact_dir = abspath(artifact"IpoptMKL")

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    # We first need to add to LIBPATH_list the libraries provided by Julia
    append!(LIBPATH_list, [joinpath(Sys.BINDIR, Base.LIBDIR, "julia"), joinpath(Sys.BINDIR, Base.LIBDIR)])
    # From the list of our dependencies, generate a tuple of all the PATH and LIBPATH lists,
    # then append them to our own.
    foreach(p -> append!(PATH_list, p), (ASL_jll.PATH_list, MKL_jll.PATH_list, CompilerSupportLibraries_jll.PATH_list,))
    foreach(p -> append!(LIBPATH_list, p), (ASL_jll.LIBPATH_list, MKL_jll.LIBPATH_list, CompilerSupportLibraries_jll.LIBPATH_list,))

    global amplexe_path = normpath(joinpath(artifact_dir, amplexe_splitpath...))

    push!(PATH_list, dirname(amplexe_path))
    global libipopt_path = normpath(joinpath(artifact_dir, libipopt_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libipopt_handle = dlopen(libipopt_path)
    push!(LIBPATH_list, dirname(libipopt_path))

    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(LIBPATH_list, ':')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()

