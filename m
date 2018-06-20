Received: from eggs.gnu.org ([2001:4830:134:3::10]:35294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVYgc-0003fx-9p
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVYgb-0004Be-Du
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:41:54 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:33235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVYga-0004BE-VI
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:41:53 -0400
Received: by mail-ot0-x236.google.com with SMTP id h6-v6so2858225otj.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 01:41:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618184448.13592-1-mark.cave-ayland@ilande.co.uk>
References: <20180618184448.13592-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 09:41:31 +0100
Message-ID: <CAFEAcA_XZ103eQz=fVvXOtncrFTd+YBy83SQUYeT_PdNev8mZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-openbios queue 20180618
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

On 18 June 2018 at 19:44, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-openbios-20180618
>
> for you to fetch changes up to 5b20e4cacecb62fb2bdc6867c11d44cddd77c4ff:
>
>   Update OpenBIOS images to 8fe6f5f96f built from submodule. (2018-06-18 19:22:16 +0100)
>
> ----------------------------------------------------------------
> qemu-openbios queue
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to 8fe6f5f96f built from submodule.
>
>  pc-bios/openbios-ppc     | Bin 754936 -> 763128 bytes
>  pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
>  pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
>  roms/openbios            |   2 +-
>  4 files changed, 1 insertion(+), 1 deletion(-)


Applied, thanks.

-- PMM
