Received: from eggs.gnu.org ([2001:4830:134:3::10]:60397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdiDX-0007JC-6d
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdiDW-0000e0-80
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:29:35 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdiDV-0000dW-RA
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:29:34 -0400
Received: by mail-oi0-x243.google.com with SMTP id q11-v6so32659451oic.12
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 13:29:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180712200152.28569-1-sw@weilnetz.de>
References: <20180712200152.28569-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 21:29:12 +0100
Message-ID: <CAFEAcA-D_Kw33EeMrCg4k=B0yLB8U_X92OC09BQ1JKH4UiYUNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs: Fix some typos (most found by
 codespell)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>

On 12 July 2018 at 21:01, Stefan Weil <sw@weilnetz.de> wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  docs/COLO-FT.txt                     | 2 +-
>  docs/config/mach-virt-graphical.cfg  | 2 +-
>  docs/config/mach-virt-serial.cfg     | 2 +-
>  docs/config/q35-emulated.cfg         | 2 +-
>  docs/config/q35-virtio-graphical.cfg | 2 +-
>  docs/config/q35-virtio-serial.cfg    | 2 +-
>  docs/interop/vhost-user.txt          | 4 ++--
>  docs/replay.txt                      | 2 +-
>  docs/specs/tpm.txt                   | 2 +-
>  9 files changed, 10 insertions(+), 10 deletions(-)

Hi. A bunch of these are fixed by this patch posted last month
https://patchwork.kernel.org/patch/10459487/

which seems to have got lost because our qemu-trivial
patch process has stalled out. I think we should apply
that and then see what still remains to be fixed
after that.

thanks
-- PMM
