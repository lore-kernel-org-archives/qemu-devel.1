Received: from eggs.gnu.org ([2001:4830:134:3::10]:33364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgT7r-0002kx-F8
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 06:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgT7q-0004ad-LC
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 06:59:07 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:41071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgT7q-0004aV-FY
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 06:59:06 -0400
Received: by mail-oi0-x22b.google.com with SMTP id k12-v6so20585239oiw.8
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 03:59:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180720040337.21426-1-richard.henderson@linaro.org>
References: <20180720040337.21426-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 11:58:45 +0100
Message-ID: <CAFEAcA-C1YqFydxGFhWAH0gYvr3wiPaLyNkc5NOzXu5OUQ0anA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.0 0/1] tcg-next pull
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

On 20 July 2018 at 05:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Just one patch for rc2, fixing a bug with an aarch64 host
> emulating sve instructions.
>
>
> r~
>
>
> The following changes since commit e1ea55668ffe6ce558a063f3a9621b761738e1f2:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-07-19 15:38:06 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20180719
>
> for you to fetch changes up to e65a5f227d77a5dbae7a7123c3ee915ee4bd80cf:
>
>   tcg/aarch64: limit mul_vec size (2018-07-19 09:07:31 -0700)
>
> ----------------------------------------------------------------
> Fix aarch64 host vector mul
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
