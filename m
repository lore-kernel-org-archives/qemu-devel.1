Received: from eggs.gnu.org ([2001:4830:134:3::10]:54656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWHtr-0007Ez-NO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWHtr-0007P6-0O
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:58:35 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:35276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWHtq-0007Og-QZ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:58:34 -0400
Received: by mail-ot0-x232.google.com with SMTP id q17-v6so6716808otg.2
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 01:58:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621143715.27176-1-richard.henderson@linaro.org>
References: <20180621143715.27176-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 09:58:13 +0100
Message-ID: <CAFEAcA9dGUOLhxHr+AYHCfTvStM+M7DLVBiHEmnDzpX38aggBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2.5 00/19] tcg queued patches
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

On 21 June 2018 at 15:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Re-issuing the v2 pull request with the proper form.
>
>
> r~
>
>
> The following changes since commit 42747d6abb5035473e5585fa17620c1e8983a70b:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-06-15.for-upstream' into staging (2018-06-15 17:28:37 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20180615
>
> for you to fetch changes up to 9f754620651d3432114f4bb89c7f12cbea814b3e:
>
>   tcg: Reduce max TB opcode count (2018-06-15 09:39:53 -1000)
>
> ----------------------------------------------------------------
> TCG patch queue:
>
> Workaround macos assembler lossage.
> Eliminate tb_lock.
> Fix TB code generation overflow.
>
Applied, thanks.

-- PMM
