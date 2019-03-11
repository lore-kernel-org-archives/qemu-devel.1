Received: from eggs.gnu.org ([209.51.188.92]:52350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3PdG-0001Qj-98
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3PdF-00022w-AE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:26:38 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:36367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3PdF-00021x-1U
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:26:37 -0400
Received: by mail-oi1-x233.google.com with SMTP id t206so4481903oib.3
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 18:26:24 +0000
Message-ID: <CAFEAcA-3PZkOu-WcL2OVy-4LS+bwOvhORREU1NfgFryydiKoHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] MIPS queue for March 11th, 2019
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

On Mon, 11 Mar 2019 at 14:24, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit e2a18635a400b0e68679614132e9ef6316105590:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03-08' into staging (2019-03-09 20:55:44 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-mar-11-2019
>
> for you to fetch changes up to 53e116fed6dde572003aebf3bc32e25663eeb446:
>
>   target/mips: Add tests for a variety of MSA integer subtract instructions (2019-03-11 12:45:36 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for March 11th, 2019
>
>   - MIPS TCG tests updates and cleanups
>
>   Note:
>
>   - six checkpatch.pl warnings on "MAINTAINERS" can be ignored
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
