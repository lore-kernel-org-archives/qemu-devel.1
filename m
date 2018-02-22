Received: from eggs.gnu.org ([2001:4830:134:3::10]:56810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eos75-0008Or-J3
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eos74-0006s6-Cz
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:44:47 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:40147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eos74-0006rX-7Y
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:44:46 -0500
Received: by mail-oi0-x234.google.com with SMTP id c12so3855067oic.7
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:44:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180222082341.sk2pkai7kf5kurfh@kentang.home>
References: <20180222082341.sk2pkai7kf5kurfh@kentang.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 14:44:25 +0000
Message-ID: <CAFEAcA-yzR+YwpmcXT45X3pnE78vHveL4eQF_Ly9o=BV=oKfFQ@mail.gmail.com>
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

On 22 February 2018 at 08:23, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> This update for OpenBIOS contains a single fix which allows yaboot 1.3.17 to boot
> under qemu-system-ppc. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit a6e0344fa0e09413324835ae122c4cadd7890231:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-request' into staging (2018-02-20 14:05:00 +0000)
>
> are available in the git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-openbios-signed
>
> for you to fetch changes up to feb3174ff27f94d34247952d9779f09e9b1dfd39:
>
>   Update OpenBIOS images to 54d959d9 built from submodule. (2018-02-22 07:55:47 +0000)
>
> ----------------------------------------------------------------
> Update OpenBIOS images
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to 54d959d9 built from submodule.
>
>  pc-bios/openbios-ppc     | Bin 754936 -> 754936 bytes
>  pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
>  pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
>  roms/openbios            |   2 +-
>  4 files changed, 1 insertion(+), 1 deletion(-)


Applied, thanks.

-- PMM
