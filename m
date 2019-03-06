Received: from eggs.gnu.org ([209.51.188.92]:56213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1Ts5-0004L2-TK
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1Ts4-0001Td-TN
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:33:57 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:35841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1Ts3-0001EC-Qz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:33:56 -0500
Received: by mail-oi1-x230.google.com with SMTP id t206so9435896oib.3
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 02:33:52 -0800 (PST)
MIME-Version: 1.0
References: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Mar 2019 10:33:40 +0000
Message-ID: <CAFEAcA9Ddu+5QjHNy24-5yx7cS35qdrBte96wu1bEZVq3w3oyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] MIPS queue for March 5th, 2019
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

On Tue, 5 Mar 2019 at 18:05, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a2d:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-03-05 09:33:20 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-mar-05-2019
>
> for you to fetch changes up to 0fdd986a6c8f921693d025c3f095a0eaf628b6b6:
>
>   target/mips: Add tests for integer add MSA instruction group (2019-03-05 17:05:33 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for March 5th, 2019
>
>   * cosmetic improvements of nanoMIPS disassembler code
>   * MIPS TCG tests infrastructure improvements
>   * new MIPS64R6 TCG tests
>   * new MSA TCG tests
>
>   Note:
>
>   * several "MAINTAINERS" and two comment-related checkpatch.pl
>   warnings are benign and can be ignored
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
