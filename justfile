[private]
_default:
    @just --list

# Run pre-commit on all files
lint:
    pre-commit run --all --show-diff-on-failure --color always

# Generate draft GitHub release
release:
    gh release create --generate-notes --draft

update:
    #!/usr/bin/env nu
    let discover_url = $"https://api.fly.io/app/flyctl_releases/Linux/x86_64/latest"
    let download_url = http get $discover_url
    let version = (
        $download_url
        | parse --regex "/v(?<version>[0-9.]+)/"
        | first
        | get version
    )
    let temp_dir = mktemp --directory
    let cleanup = { rm --recursive --force $temp_dir }
    try {
        let archive = $"($temp_dir)/archive.tar.gz"
        $"Downloading <($download_url)>..." | print
        http get $download_url | save --raw $archive
        "Computing checksum..." | print
        let checksum = open --raw $archive | hash sha256
        (
            open --raw action.yml
            | ^awk -f update.awk
                $"VERSION=($version)"
                $"CHECKSUM=($checksum)"
            | save --raw $"($temp_dir)/action.yml"
        )
        mv $"($temp_dir)/action.yml" .

    } catch {|err|
        do $cleanup
        error make $err
    }
    do $cleanup
