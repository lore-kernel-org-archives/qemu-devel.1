Received: from eggs.gnu.org ([2001:4830:134:3::10]:59246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVyZw-0002Dn-6d
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVyZv-0000Y6-4b
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:16:12 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:34864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVyZu-0000Xb-Tw
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:16:11 -0400
Received: by mail-wm0-x22b.google.com with SMTP id w126so17615584wme.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:16:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713191252.GB20141@kentang.lan>
References: <20170713191252.GB20141@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 12:15:49 +0100
Message-ID: <CAFEAcA9eB8XzD_4_MshkpCMyh8A2SjUsKSvrm2rMg3GoP4Oiow@mail.gmail.com>
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

On 13 July 2017 at 20:12, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here are the latest set of updates for OpenBIOS. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d4f:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12' into staging (2017-07-13 16:56:06 +0100)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-openbios-signed
>
> for you to fetch changes up to abcea034a05e617866d456bf6afc4c4d4ea26151:
>
>   Update OpenBIOS images to fbc1b4a built from submodule. (2017-07-13 19:44:45 +0100)
>
> ----------------------------------------------------------------
> Update OpenBIOS images
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to fbc1b4a built from submodule.
>
>  pc-bios/openbios-ppc     |  Bin 750840 -> 754936 bytes
>  pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
>  pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
>  roms/openbios            |    2 +-
>  4 files changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- PMM
