Received: from eggs.gnu.org ([208.118.235.92]:59429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf68Z-00055U-09
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gf68X-0001cU-6S
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:46:26 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:35366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gf68W-0001b5-Li
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:46:25 -0500
Received: by mail-oi1-x233.google.com with SMTP id v6so28149208oif.2
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 08:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20181226172005.26990-1-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jan 2019 16:46:11 +0000
Message-ID: <CAFEAcA8t7V3XwkPCSKCPCd1qc=MxZcw2yjoHMW-NmTzGWMkbVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V Changes for 3.2, Part 1
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

On Wed, 26 Dec 2018 at 17:20, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The following changes since commit b72566a4ffaddbc0c0c1f6f5ee91b42ab13ff429:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2018-12-19 15:31:02 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-3.2-part1
>
> for you to fetch changes up to 7b91ae7d7944056c5e8045342e4039e978e43c82:
>
>   MAINTAINERS: Mark RISC-V as Supported (2018-12-21 07:57:15 -0800)
>
> ----------------------------------------------------------------
> RISC-V Changes for 3.2, Part 1
>
> This pull request contains the first set of RISC-V patches I'd like to
> target for the 3.2 development cycle.  It's really just a collection of
> bug fixes with one major new feature: PCIe can now be attached to RISC-V
> guests.
>
> This has passed my usual test of booting the latest Linux RC into a
> Fedora disk image on the virt machine.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
