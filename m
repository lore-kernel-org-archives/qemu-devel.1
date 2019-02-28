Received: from eggs.gnu.org ([209.51.188.92]:44639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzOHG-0003Tt-OI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzOHF-0007vL-Va
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:11:18 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:46641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzOHF-0007uL-N2
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:11:17 -0500
Received: by mail-oi1-x22e.google.com with SMTP id j135so16932107oib.13
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 08:11:17 -0800 (PST)
MIME-Version: 1.0
References: <1551276045-19143-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551276045-19143-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 16:11:05 +0000
Message-ID: <CAFEAcA9Q8HEUJrZ3eC_VzkTviRb0PuJ2hELZDZ9o--JGku637A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] MIPS queue for February 27th, 2019
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Wed, 27 Feb 2019 at 14:00, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
>   Merge remote-tracking branch 'remotes/berrange/tags/authz-core-pull-request' into staging (2019-02-26 17:59:41 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-feb-27-2019
>
> for you to fetch changes up to 37b9aae2e6e005e6df206a0b4804972460806166:
>
>   target/mips: Preparing for adding MMI instructions (2019-02-27 14:26:14 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for February 27th, 2019
>
>   - addition of two sets of new MSA ASE TCG tests
>   - preparation for adding MMI instructions in translate.c
>   - fixing a function misnomer in nanoMIPS disassembler
>   - MIPS end user documentation updates
>
> NOTES:
>
>   - there are two checkpatch.pl's warnings on "updating MAINTAINERS"
>     that can be ignored
>   - all patches contain "message-id" now
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
