{
  appimageTools,
  fetchurl,
  runCommand,
  writeShellApplication,
  coreutils,
  llama-cpp,
  nvidiaPackage,
}:

let
  pname = "bethaniel";
  version = "1.2.10";

  src = fetchurl {
    url = "https://github.com/SimonGrund/bethaniel/releases/download/v${version}/Bethaniel-linux.AppImage";
    hash = "sha256-qnr2rTYNlU2Qs3DhH/10loeSxowsIupXN/Xn4FRxrbE=";
  };

  # CUDA build so inference runs on the GPU. Finds libcuda at runtime from
  # /run/opengl-driver, which is reachable inside the FHS sandbox via the /run bind.
  llamaCuda = llama-cpp.override { cudaSupport = true; };

  # The app's detectNGL() decides GPU offload with a fragile 3s nvidia-smi probe
  # that is all-or-nothing (-ngl 999 or -ngl 0), so fitting models often end up on
  # CPU and oversized ones OOM. This wrapper takes the app's spot as `llama-server`,
  # drops the app's -ngl, recomputes it from free VRAM vs model size (full offload
  # when it fits with headroom, else CPU), then execs the real CUDA binary.
  llamaWrapper = writeShellApplication {
    name = "llama-server";
    runtimeInputs = [
      nvidiaPackage
      coreutils
    ];
    text = ''
      model=""
      args=()
      expect_ngl_val=0
      expect_model=0
      for a in "''$@"; do
        if [ "''$expect_ngl_val" -eq 1 ]; then expect_ngl_val=0; continue; fi
        if [ "''$a" = "-ngl" ]; then expect_ngl_val=1; continue; fi
        args+=("''$a")
        if [ "''$expect_model" -eq 1 ]; then model="''$a"; expect_model=0; fi
        if [ "''$a" = "-m" ]; then expect_model=1; fi
      done

      ngl=0
      free=''$( (nvidia-smi --query-gpu=memory.free --format=csv,noheader,nounits 2>/dev/null || true) | head -n1 | tr -dc '0-9' )
      if [ -n "''${free:-}" ] && [ -n "''$model" ] && [ -f "''$model" ]; then
        size_mib=''$(( ''$(stat -c %s "''$model") / 1048576 ))
        # Full offload only if the model plus ~2 GiB headroom (KV cache, context,
        # desktop) fits in free VRAM; otherwise stay on CPU to avoid an OOM crash.
        if [ "''$free" -gt ''$(( size_mib + 2048 )) ]; then
          ngl=999
        fi
      fi

      exec ${llamaCuda}/bin/llama-server "''${args[@]}" -ngl "''$ngl"
    '';
  };

  extracted = appimageTools.extractType2 { inherit pname version src; };

  # The bundled llama-server is dynamically broken on NixOS (libllama-common.so.0).
  # Drop it so the app's findLlamaBin() falls back to `llama-server` on PATH, which
  # we supply via llamaWrapper in extraPkgs below.
  contents = runCommand "${pname}-${version}-patched" { } ''
    cp -r ${extracted} $out
    chmod -R u+w $out
    rm -f $out/resources/llama/linux-x64/llama-server
  '';
in
appimageTools.wrapAppImage {
  inherit pname version;
  src = contents;

  extraPkgs = _pkgs: [ llamaWrapper ];

  extraInstallCommands = ''
    install -Dm444 ${contents}/bethaniel.desktop -t $out/share/applications
    install -Dm444 ${contents}/usr/share/icons/hicolor/512x512/apps/bethaniel.png \
      -t $out/share/icons/hicolor/512x512/apps
    substituteInPlace $out/share/applications/bethaniel.desktop \
      --replace-fail 'Exec=AppRun --no-sandbox %U' 'Exec=bethaniel --no-sandbox %U'
  '';

  meta = {
    description = "Private, local AI copy editor for pre-print manuscripts";
    homepage = "https://github.com/SimonGrund/bethaniel";
    mainProgram = "bethaniel";
  };
}
