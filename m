Received: from eggs.gnu.org ([209.51.188.92]:57656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtGiN-0008W2-JS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtGiJ-0003q8-VP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:53:57 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtGiG-0003m9-96
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:53:54 -0500
Received: by mail-ot1-x331.google.com with SMTP id 98so6699773oty.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 10:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20190211170136.18680-1-richard.henderson@linaro.org>
In-Reply-To: <20190211170136.18680-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Feb 2019 18:53:34 +0000
Message-ID: <CAFEAcA9HtznEPVNdJetLjJqm5Un26ccK1jca6XTxQX4btc-mKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] tcg queued patches
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

On Mon, 11 Feb 2019 at 17:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit a044e3de2917d54b95f1211f4d14ec30cac9a59f:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-110219-1' into staging (2019-02-11 14:47:44 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190211
>
> for you to fetch changes up to 6d967cb86d5b4a60ba15b497126b621ce9ca6609:
>
>   cputlb: update TLB entry/index after tlb_fill (2019-02-11 08:52:44 -0800)
>
> ----------------------------------------------------------------
> Fix dynamic tlb resize
> Fix x86 host vector saturation
> Diagnose missing tcg labels
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
