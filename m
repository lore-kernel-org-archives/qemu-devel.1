Received: from eggs.gnu.org ([209.51.188.92]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grjCt-0005UA-3b
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grjCr-0001vJ-Ub
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:55:07 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:44629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grjCr-0001tn-OY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:55:05 -0500
Received: by mail-ot1-x333.google.com with SMTP id e24so8680505otp.11
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 04:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20190206043516.11462-1-richard.henderson@linaro.org>
In-Reply-To: <20190206043516.11462-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 12:54:51 +0000
Message-ID: <CAFEAcA-U40+zDwnR29NQkpgz3m+izm23SrDm3ZPk8uJ=y7JOqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] tcg queued patches
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

On Wed, 6 Feb 2019 at 04:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190206
>
> for you to fetch changes up to 9fd9b7de61b24c70a8a82d9627a20ed95433e1b5:
>
>   accel/tcg: Consider cluster index in tb_lookup__cpu_state() (2019-02-06 03:39:24 +0000)
>
> ----------------------------------------------------------------
> Queued accel/tcg patches
>
> ----------------------------------------------------------------
> Catherine Ho (1):
>       tcg: add early clober modifier in atomic16_cmpxchg on aarch64
>
> Peter Maydell (1):
>       accel/tcg: Consider cluster index in tb_lookup__cpu_state()

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
