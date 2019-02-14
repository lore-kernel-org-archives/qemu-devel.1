Received: from eggs.gnu.org ([209.51.188.92]:38743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guNHl-00022N-2w
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 15:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guN3j-0008AJ-As
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:52:37 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:40098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guN3c-00085N-LH
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:52:31 -0500
Received: by mail-ot1-x334.google.com with SMTP id s5so12611862oth.7
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:52:26 -0800 (PST)
MIME-Version: 1.0
References: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:52:14 +0000
Message-ID: <CAFEAcA_AX-AkSnXFCB8eKHQ0+yAFFpRK2pRaTokwHu5kZtOAtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] MIPS queue for February 14th, 2019
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

On Thu, 14 Feb 2019 at 17:47, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 7e407466b1efbd65225cc72fe09c0c5ec79df75b:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-02-14 15:22:29 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-feb-14-2019
>
> for you to fetch changes up to ba632924450faf6741d299f8feed8150a0c6f884:
>
>   tests/tcg: target/mips: Add tests for MSA logic instructions (2019-02-14 17:47:37 +0100)
>
> ----------------------------------------------------------------
> MIPS queue for February 14th, 2019
>
>   - MTTCG support for MIPS
>   - The first part of MSA ASE tests
>
> There are several checkpatch warnings that should be all ignored.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes. (I note that the "MIPS" section is
currently quite empty-looking.)

-- PMM
