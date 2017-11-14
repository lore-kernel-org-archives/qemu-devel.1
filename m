Received: from eggs.gnu.org ([2001:4830:134:3::10]:58831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEf72-00084u-AO
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEf71-0000pv-Iy
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:35:04 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:51109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEf71-0000pN-CD
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:35:03 -0500
Received: by mail-wr0-x234.google.com with SMTP id p96so18171975wrb.7
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 09:35:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171114144002.20156-1-kraxel@redhat.com>
References: <20171114144002.20156-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2017 17:34:41 +0000
Message-ID: <CAFEAcA-e=zC5jFhQvHLg0LySi47LiCDho8cZJ69qrPdbdVvtmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Seabios 1.11 final 20171114 patches
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

On 14 November 2017 at 14:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 2e550e31518f90cc9cb7e5c855a1995c317463a3:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20171110-pull-request' into staging (2017-11-14 08:39:50 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-1.11-final-20171114-pull-request
>
> for you to fetch changes up to 6350b2a09b8a330cbfaea462a34bbb1b8c63d7b1:
>
>   seabios: update to 1.11 final (2017-11-14 15:36:08 +0100)
>
> ----------------------------------------------------------------
> seabios: update to 1.11 final
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   seabios: update to 1.11 final
>
>  pc-bios/bios-256k.bin      | Bin 262144 -> 262144 bytes
>  pc-bios/bios.bin           | Bin 131072 -> 131072 bytes
>  pc-bios/vgabios-cirrus.bin | Bin 38400 -> 38400 bytes
>  pc-bios/vgabios-qxl.bin    | Bin 38912 -> 38912 bytes
>  pc-bios/vgabios-stdvga.bin | Bin 38912 -> 38912 bytes
>  pc-bios/vgabios-virtio.bin | Bin 38912 -> 38912 bytes
>  pc-bios/vgabios-vmware.bin | Bin 38912 -> 38912 bytes
>  pc-bios/vgabios.bin        | Bin 38400 -> 38400 bytes
>  roms/seabios               |   2 +-
>  9 files changed, 1 insertion(+), 1 deletion(-)
>

Applied, thanks.

-- PMM
