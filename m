Received: from eggs.gnu.org ([2001:4830:134:3::10]:49215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNGod-0001vi-16
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 06:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNGoc-00014L-9E
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 06:55:23 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNGoc-00014H-3O
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 06:55:22 -0400
Received: by mail-wm0-x231.google.com with SMTP id m125so18109202wmm.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 03:55:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170615081711.25347-1-laurent@vivier.eu>
References: <20170615081711.25347-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 11:54:59 +0100
Message-ID: <CAFEAcA8ckCwT1ttQepbLWjre7hbcHX5WfTEPOcYpK9XKfEmKMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] M68k for 2.10 patches
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

On 15 June 2017 at 09:17, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.10-pull-request
>
> for you to fetch changes up to 69e698220f68a17ce9584b068f68ed09e527a6ad:
>
>   target-m68k: define ext_opsize (2017-06-15 09:16:38 +0200)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Laurent Vivier (4):
>   target/m68k: fix V flag for CC_OP_SUBx
>   softfloat: define 680x0 specific values
>   target-m68k: move FPU helpers to fpu_helper.c
>   target-m68k: define ext_opsize
Applied, thanks.

-- PMM
