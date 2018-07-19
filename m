Received: from eggs.gnu.org ([2001:4830:134:3::10]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgCgj-0004KH-9k
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 13:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgCgi-0004KX-6a
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 13:26:01 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:36609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgCgh-0004Jv-Pa
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 13:26:00 -0400
Received: by mail-oi0-x22a.google.com with SMTP id n21-v6so921161oig.3
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 10:25:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180719160721.18430-1-alistair.francis@wdc.com>
References: <20180719160721.18430-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 18:25:38 +0100
Message-ID: <CAFEAcA9OoUmdD0GH6p00y6GhtHK4jp-kSYSpz9MULU22uRf40Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 for 3.0 0/5] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 19 July 2018 at 17:07, Alistair Francis <alistair.francis@wdc.com> wrote:
> The following changes since commit e1ea55668ffe6ce558a063f3a9621b761738e1f2:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-07-19 15:38:06 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180719
>
> for you to fetch changes up to 8ff62f6aa067edd5455d60202041b4ae08a65b17:
>
>   spike: Fix crash when introspecting the device (2018-07-19 09:05:48 -0700)
>
> ----------------------------------------------------------------
> riscv: Fix introspection problems
>
> This is based on Thomas's work fixing introspection problems [1] and
> applied to the RISC-V port.
>
> 1: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03261.html
>

Applied, thanks.

-- PMM
