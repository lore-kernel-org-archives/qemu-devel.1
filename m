Received: from eggs.gnu.org ([2001:4830:134:3::10]:35314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8UIO-0000to-9f
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8UHm-0002Lg-5p
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:53:10 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:45862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8UHl-0002JN-Mi
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:53:10 -0400
Received: by mail-oi1-x22c.google.com with SMTP id e17-v6so11059914oig.12
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 10:53:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005085132.26394-1-mark.cave-ayland@ilande.co.uk>
References: <20181005085132.26394-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 18:52:47 +0100
Message-ID: <CAFEAcA95x9wrqxO5_0xLiP4s=8oRUEwCnWNg81XS7=dz4bjdsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] qemu-openbios.for-upstream queue
 20181005
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

On 5 October 2018 at 09:51, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> The following changes since commit dafd95053611aa14dda40266857608d12ddce658:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-02 18:27:18 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-openbios.for-upstream-20181005
>
> for you to fetch changes up to 422d33b8c847fe1264099f93ec8ddb2e56772d4d:
>
>   Update OpenBIOS images to 441a84d3 built from submodule. (2018-10-05 09:25:14 +0100)
>
> ----------------------------------------------------------------
> qemu-openbios.for-upstream queue
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to 441a84d3 built from submodule.
>
>  pc-bios/openbios-ppc     | Bin 767224 -> 767224 bytes
>  pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
>  pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
>  roms/openbios            |   2 +-

Applied, thanks.

-- PMM
