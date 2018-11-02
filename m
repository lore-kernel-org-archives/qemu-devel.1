Received: from eggs.gnu.org ([2001:4830:134:3::10]:36482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIZu9-0000Vm-Vi
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIZu2-0005jp-N1
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:54:28 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:36684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIZty-0005iL-Rg
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:54:20 -0400
Received: by mail-ot1-x333.google.com with SMTP id x4so1754692otg.3
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:54:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181101235525.29042-1-palmer@sifive.com>
References: <20181101235525.29042-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 13:53:56 +0000
Message-ID: <CAFEAcA-h0iQ2RcCkkE66mLxjXZ9YOZG3STAO3Bv5C3rQ7jyhdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for the 3.1 Soft Freeze,
 Part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: qemu-riscv@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On 1 November 2018 at 23:55, Palmer Dabbelt <palmer@sifive.com> wrote:
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-sf1
>
> for you to fetch changes up to a094b3544f2855c0489f5df3c938b14b9a5899e5:
>
>   Add qemu-riscv@nongnu.org as the RISC-V list (2018-10-30 11:04:29 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 3.1 Soft Freeze, Part 2
>
> This tag contains a few simple patches that I'd like to target for the
> QEMU soft freeze.  There's only one code change: a fix to our PMP
> implementation that avoids an internal truncation while computing a
> partial PMP read.
>
> I also have two updates to the MAINTAINERS file: one to add Alistair as
> a RISC-V maintainer, and one to add our newly created mailing list.
>

Applied, thanks.

-- PMM
