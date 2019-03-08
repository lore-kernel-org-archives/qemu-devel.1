Received: from eggs.gnu.org ([209.51.188.92]:54293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2IMD-00010i-Tg
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2IMB-0007E3-Uj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:28:25 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:35984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2IM9-0007BH-Tx
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:28:22 -0500
Received: by mail-ot1-x32e.google.com with SMTP id v62so17859828otb.3
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 08:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20190308015830.10980-1-richard.henderson@linaro.org>
In-Reply-To: <20190308015830.10980-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 16:28:09 +0000
Message-ID: <CAFEAcA8Dx2M95Q94E3fY0PdF=-=wJEQOPDbzxXHJdW-+30D=sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] target/hppa updates
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

On Fri, 8 Mar 2019 at 01:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 6cb4f6db4f4367faa33da85b15f75bbbd2bed2a6:
>
>   Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-03-07 16:16:02 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190307
>
> for you to fetch changes up to b35aec8597e86911d5553c94769f914a52a8b389:
>
>   target/hppa: Optimize blr r0,rn (2019-03-07 17:43:12 -0800)
>
> ----------------------------------------------------------------
> Fix use after free on temporary.
> Optmize branch to next insn via br r0.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
