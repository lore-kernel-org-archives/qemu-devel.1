Received: from eggs.gnu.org ([2001:4830:134:3::10]:60361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIW5I-00048B-2r
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIW5G-0001Xs-H4
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:49:43 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:37350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIW5G-0001XC-8r
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 05:49:42 -0400
Received: by mail-ot1-x32e.google.com with SMTP id 40so956006oth.4
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 02:49:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181031165321.4422-1-richard.henderson@linaro.org>
References: <20181031165321.4422-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 09:49:21 +0000
Message-ID: <CAFEAcA95y2S2Y=VSEQu-bJ=EJwNtPEoh3SByHWneNDQ90m+04Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] decodetree improvements
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

On 31 October 2018 at 16:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-dt-20181031
>
> for you to fetch changes up to 6699ae6a8e74381583622502db8bd47fac381c9e:
>
>   decodetree: Allow multiple input files (2018-10-31 16:48:58 +0000)
>
> ----------------------------------------------------------------
> Updates to decodetree.py for risc-v.
>
> ----------------------------------------------------------------
> Richard Henderson (3):
>       decodetree: Add !extern flag to argument sets
>       decodetree: Remove "insn" argument from trans_* expanders
>       decodetree: Allow multiple input files

Applied, thanks.

-- PMM
