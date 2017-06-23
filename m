Received: from eggs.gnu.org ([2001:4830:134:3::10]:36853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOKCo-0005C4-IG
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOKCn-0006es-OB
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:44:42 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dOKCn-0006ea-HE
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:44:41 -0400
Received: by mail-wr0-x231.google.com with SMTP id 77so56082223wrb.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 01:44:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170621210047.24083-1-laurent@vivier.eu>
References: <20170621210047.24083-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2017 09:44:19 +0100
Message-ID: <CAFEAcA8-R3RaF_QpSz1BzLK36BzPBjamqyCtfxvED_Nufqs=HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] M68k for 2.10 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 June 2017 at 22:00, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 8dfaf23ae1f2273a9730a9b309cc8471269bb524:
>
>   tcg/tci: fix tcg-interpreter build (2017-06-20 18:39:15 +0100)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.10-pull-request
>
> for you to fetch changes up to ba62494483ab51ee31c70952b6ce5171a31860b1:
>
>   target-m68k: add FPCR and FPSR (2017-06-21 22:11:55 +0200)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Laurent Vivier (5):
>   target-m68k: move fmove CR to a function
>   target-m68k: initialize FPU registers
>   target-m68k: use floatx80 internally
>   target-m68k: define 96bit FP registers for gdb on 680x0
>   target-m68k: add FPCR and FPSR
>

Applied, thanks.

-- PMM
