Received: from eggs.gnu.org ([2001:4830:134:3::10]:40113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebWRK-0004Dh-6n
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:58:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebWRI-0007Ws-PO
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:58:30 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:43422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebWRI-0007VZ-HZ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:58:28 -0500
Received: by mail-oi0-x22d.google.com with SMTP id t16so11333538oif.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:58:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116164600.7480-1-richard.henderson@linaro.org>
References: <20180116164600.7480-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 18:58:06 +0000
Message-ID: <CAFEAcA-2D_umy+TbRO_7RsvLB1RkSY_pKHZ1ir_JX=GLWaJ0Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/4] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 January 2018 at 16:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
> With comments addressed from v1.
>
>
> r~
>
>
>
> The following changes since commit aae39d24a387a273deab3eb930dbf730aa379e22:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180116' into staging (2018-01-16 14:18:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20180116
>
> for you to fetch changes up to 030ffe39dd4128eb90483af82a5b23b23054a466:
>
>   tcg/ppc: Allow a 32-bit offset to the constant pool (2018-01-16 08:21:56 -0800)
>
> ----------------------------------------------------------------
> Queued TCG patches
>
> ----------------------------------------------------------------
> Richard Henderson (4):
>       tcg/arm: Fix double-word comparisons
>       tcg/arm: Support tlb offsets larger than 64k
>       tcg/ppc: Support tlb offsets larger than 64k
>       tcg/ppc: Allow a 32-bit offset to the constant pool

Applied, thanks.

-- PMM
