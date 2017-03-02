Received: from eggs.gnu.org ([2001:4830:134:3::10]:34731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjR6f-0001lK-Ur
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjR6e-00033f-Ms
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:49:22 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjR6e-00032j-Fu
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:49:20 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v186so135612919wmd.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 05:49:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228221644.GA30636@kentang.lan>
References: <20170228221644.GA30636@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 13:48:58 +0000
Message-ID: <CAFEAcA9iCuHxsRcUGr0uO89jbjkmXzdFjckogNL47Y5q27dtEQ@mail.gmail.com>
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

On 28 February 2017 at 22:16, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here are the OpenBIOS updates for QEMU 2.9. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit e7c83a885f865128ae3cf1946f8cb538b63cbfba:
>
>   vhost-user: delay vhost_user_stop (2017-02-28 19:11:15 +0000)
>
> are available in the git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-openbios-signed
>
> for you to fetch changes up to 9b40d1ee130432c8d80bfabde85918f187b4ae32:
>
>   Update OpenBIOS images to 0cd97cc built from submodule. (2017-02-28 21:50:03 +0000)
>
> ----------------------------------------------------------------
> Update OpenBIOS images
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       Update OpenBIOS images to 0cd97cc built from submodule.
>
>  pc-bios/openbios-ppc     |  Bin 750840 -> 750840 bytes
>  pc-bios/openbios-sparc32 |  Bin 382048 -> 382048 bytes
>  pc-bios/openbios-sparc64 |  Bin 1593408 -> 1593408 bytes
>  roms/openbios            |    2 +-
>  4 files changed, 1 insertion(+), 1 deletion(-)


Applied, thanks.

-- PMM
