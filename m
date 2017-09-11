Received: from eggs.gnu.org ([2001:4830:134:3::10]:34410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drOrJ-0004Kd-6t
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drOrI-0005WY-AD
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:34:41 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drOrI-0005Vs-3Y
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:34:40 -0400
Received: by mail-wr0-x22a.google.com with SMTP id a43so14706557wrc.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 06:34:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170911071242.GB16807@kentang.lan>
References: <20170911071242.GB16807@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 14:34:18 +0100
Message-ID: <CAFEAcA-Q87f3eoDD9R5BvmeaRPb_nbWBc7XWvhp9srN5T5WDPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] Update OpenBIOS images
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

On 11 September 2017 at 08:12, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here are the first set of OpenBIOS updates for 2.11. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit fcea73709b966a7ded9efa7b106ea50c7fe9025c:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-09-08 16:04:42 +0100)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-openbios-signed
>
> for you to fetch changes up to 8722a719dea27818cb02709f3f72c2f9a996dadf:
>
>   Update OpenBIOS images to 314d4f8 built from submodule. (2017-09-11 07:43:34 +0100)
>
> ----------------------------------------------------------------
> Update OpenBIOS images
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to 314d4f8 built from submodule.
>
>  pc-bios/openbios-ppc     |  Bin 754936 -> 754936 bytes
>  pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
>  pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
>  roms/openbios            |    2 +-
>  4 files changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- PMM
