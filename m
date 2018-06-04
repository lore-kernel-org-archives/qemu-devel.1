Received: from eggs.gnu.org ([2001:4830:134:3::10]:43834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPo3l-0008L9-5p
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPo3k-0005oy-6k
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:54:01 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:45168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPo3j-0005op-W1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:54:00 -0400
Received: by mail-ot0-x232.google.com with SMTP id a5-v6so6090752otf.12
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 04:53:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601231403.10525-1-richard.henderson@linaro.org>
References: <20180601231403.10525-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 12:53:38 +0100
Message-ID: <CAFEAcA8oURXNaRVxfKU76cssWtFO4Pss2=6P9hw+ThAVU7_Myw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] tcg-next patch queue
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

On 2 June 2018 at 00:14, Richard Henderson <richard.henderson@linaro.org> wrote:
> The following changes since commit 392fba9f583223786f844dce9b2e7f9a0ce0147a:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-010618-1' into staging (2018-06-01 17:32:30 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/tcg-next-pull-request
>
> for you to fetch changes up to 07ea28b41830f946de3841b0ac61a3413679feb9:
>
>   tcg: Pass tb and index to tcg_gen_exit_tb separately (2018-06-01 15:15:27 -0700)
>
> ----------------------------------------------------------------
> tcg-next queue
>
> ----------------------------------------------------------------
>
> Richard Henderson (1):
>   tcg: Pass tb and index to tcg_gen_exit_tb separately

Applied, thanks.

-- PMM
