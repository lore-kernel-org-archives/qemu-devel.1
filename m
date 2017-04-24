Received: from eggs.gnu.org ([2001:4830:134:3::10]:58080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2acR-0003It-Kn
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2acQ-0007WI-I6
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:49:19 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:32784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2acQ-0007W5-CA
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:49:18 -0400
Received: by mail-wr0-x234.google.com with SMTP id w50so64954412wrc.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 02:49:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170421191751.GB2434@kentang.lan>
References: <20170421191751.GB2434@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 10:48:56 +0100
Message-ID: <CAFEAcA-BZO7_492y5_uM2=9r4dtY1VApZUHwE6q--tj=hY6qgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL] qemu-sparc update
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

On 21 April 2017 at 20:17, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here is the cg3/tcx patchset which includes a lot of tidy-up and fixes several
> invalidation bugs for tcx discovered whilst testing Gerd's thread-safe
> patches. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit da92ada855036c55bd08b0b0c64c7551d56f3586:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170420' into staging (2017-04-20 17:41:34 +0100)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to 749763864208b14f100f1f8319aeb931134430fa:
>
>   tcx: switch to load_image_mr() and remove prom_addr hack (2017-04-21 09:02:04 +0100)

Applied, thanks.

-- PMM
