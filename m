Received: from eggs.gnu.org ([209.51.188.92]:32855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKlBK-0005WD-Gg
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hKlBJ-0002ZN-AQ
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:53:30 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:39615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hKlBI-0002Z8-Vx
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:53:29 -0400
Received: by mail-ot1-x32c.google.com with SMTP id o39so6551272ota.6
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 07:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190426172421.27133-1-richard.henderson@linaro.org>
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Apr 2019 15:53:16 +0100
Message-ID: <CAFEAcA_iXkJVSgYmkBui0-PXBXqrNFnonaxsRo7gwGNHL1e3yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] tcg patch queue
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

On Fri, 26 Apr 2019 at 18:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190426
>
> for you to fetch changes up to ef5dae6805cce7b59d129d801bdc5db71bcbd60d:
>
>   cputlb: Fix io_readx() to respect the access_type (2019-04-25 10:40:06 -0700)
>
> ----------------------------------------------------------------
> Add tcg_gen_extract2_*.
> Deal with overflow of TranslationBlocks.
> Respect access_type in io_readx.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
