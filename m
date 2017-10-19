Received: from eggs.gnu.org ([2001:4830:134:3::10]:60079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5EqB-0003J0-KD
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5EqA-00029g-FO
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:42:43 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5EqA-00029H-7k
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:42:42 -0400
Received: by mail-wm0-x243.google.com with SMTP id q132so17892725wmd.2
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:42:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019082015.16432-1-kraxel@redhat.com>
References: <20171019082015.16432-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 18:42:20 +0100
Message-ID: <CAFEAcA_KEwS6JWNqgLpdTN5S36FYPODYUTrM65=zYFgsZUoCsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Seabios 1.11 prerelease 20171019 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 October 2017 at 09:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 861cd431c99e56ddb5953ca1da164a9c32b477ca:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.11-20171017' into staging (2017-10-17 15:26:51 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-1.11-prerelease-20171019-pull-request
>
> for you to fetch changes up to 083fab0290f2c40d3d04f7f22eed9c8f2d5b6787:
>
>   seabios: update to 1.11 prerelease (2017-10-19 10:14:26 +0200)
>
> ----------------------------------------------------------------
> seabios: update to 1.11 prerelease
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   seabios: update to 1.11 prerelease
>
>  pc-bios/bios-256k.bin      | Bin 262144 -> 262144 bytes
>  pc-bios/bios.bin           | Bin 131072 -> 131072 bytes
>  pc-bios/vgabios-cirrus.bin | Bin 38400 -> 38400 bytes
>  pc-bios/vgabios-qxl.bin    | Bin 38912 -> 38912 bytes
>  pc-bios/vgabios-stdvga.bin | Bin 38912 -> 38912 bytes
>  pc-bios/vgabios-virtio.bin | Bin 38912 -> 38912 bytes
>  pc-bios/vgabios-vmware.bin | Bin 38912 -> 38912 bytes
>  pc-bios/vgabios.bin        | Bin 38400 -> 38400 bytes
>  roms/config.seabios-128k   |   4 ++++
>  roms/seabios               |   2 +-
>  10 files changed, 5 insertions(+), 1 deletion(-)
>

Applied, thanks.

-- PMM
