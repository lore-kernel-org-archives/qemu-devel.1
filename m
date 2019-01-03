Received: from eggs.gnu.org ([208.118.235.92]:56444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf1ez-000662-1k
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf1ey-0002Lv-5g
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:59:37 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:33282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf1ey-0002Kn-08
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:59:36 -0500
Received: by mail-oi1-x230.google.com with SMTP id c206so27527961oib.0
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 03:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20181225205529.10874-1-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 11:59:23 +0000
Message-ID: <CAFEAcA_vkH_Go=HvOUJ1E=sFhPTEDKmtYqVs0dirstKD4tj9Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/42] tcg queued patches
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

On Tue, 25 Dec 2018 at 20:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606fdea:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into staging (2018-12-22 11:25:31 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20181226
>
> for you to fetch changes up to 4250da10923347c9ee907f8d72bd93dfa5ee8742:
>
>   tcg: Improve call argument loading (2018-12-26 06:58:43 +1100)
>
> ----------------------------------------------------------------
> Host support for riscv64.
> Dead code elimination pass.
> Register allocation improvements.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
