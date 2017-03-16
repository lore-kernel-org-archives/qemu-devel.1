Received: from eggs.gnu.org ([2001:4830:134:3::10]:36220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coSGy-0007Ol-Rb
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coSGx-0002OL-6E
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:04:44 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coSGw-0002Nm-W5
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 06:04:43 -0400
Received: by mail-wr0-x231.google.com with SMTP id g10so28203323wrg.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 03:04:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170315210714.GB26201@kentang.lan>
References: <20170315210714.GB26201@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 10:04:21 +0000
Message-ID: <CAFEAcA-TM7hdCPxTXhm09S+6qq62ZCp9shMFwin8BvEa7eUcXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9] Update OpenBIOS images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 March 2017 at 21:07, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> This update contains just the 64-bit PCI BAR fix which enables virtio modern devices to
> work once again. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-openbios-signed
>
> for you to fetch changes up to 111308e789b7a3e2771a61f68bd057f8f8b1bc22:
>
>   Update OpenBIOS images to f233c3f built from submodule. (2017-03-15 19:42:08 +0000)
>
> ----------------------------------------------------------------
> Update OpenBIOS images
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to f233c3f built from submodule.
>
>  pc-bios/openbios-ppc     |  Bin 750840 -> 750840 bytes
>  pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
>  pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
>  roms/openbios            |    2 +-
>  4 files changed, 1 insertion(+), 1 deletion(-)


Applied, thanks.

-- PMM
