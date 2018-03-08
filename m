Received: from eggs.gnu.org ([2001:4830:134:3::10]:38979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etwqM-0003Xp-HU
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etwqL-0008K1-KV
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:48:30 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etwqL-0008Jk-FH
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:48:29 -0500
Received: by mail-ot0-x243.google.com with SMTP id w38so5586571ota.8
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 06:48:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180308074714.flmzofjhz4p45ljr@kentang.home>
References: <20180308074714.flmzofjhz4p45ljr@kentang.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 14:48:08 +0000
Message-ID: <CAFEAcA9GQ9OCYE8t84veJ1-SAYKJ194SqKWLx8ozK=mj0c7URw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
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

On 8 March 2018 at 07:47, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here are a couple of last-minute fixes for SPARC. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit f32408f3b472a088467474ab152be3b6285b2d7b:
>
>   misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:30 +0000)
>
> are available in the git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to 6e10f37c86068e35151f982c976a85f1bec07ef2:
>
>   sparc: fix leon3 casa instruction when MMU is disabled (2018-03-08 07:22:03 +0000)
>
> ----------------------------------------------------------------
> qemu-sparc update
>
> ----------------------------------------------------------------
> KONRAD Frederic (1):
>       sparc: fix leon3 casa instruction when MMU is disabled
>
> Thomas Huth (1):
>       hw/sparc/sun4m: Fix implicit creation of "-drive if=scsi" devices
>
>  hw/sparc/sun4m.c         | 1 +
>  target/sparc/translate.c | 5 +++++
>  2 files changed, 6 insertions(+)



Applied, thanks.

-- PMM
