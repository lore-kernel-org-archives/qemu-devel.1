Received: from eggs.gnu.org ([2001:4830:134:3::10]:46474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXxA-0007ZW-2F
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXx4-0007lT-3V
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:31:20 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:41554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYXx3-0007iW-Sz
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:31:14 -0400
Received: by mail-ot0-x230.google.com with SMTP id d19-v6so6350585oti.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:31:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 15:30:52 +0100
Message-ID: <CAFEAcA9DfCu_gFG0G-LJ9UohVXoMU6uvjA_K8KqqZjKDamZrBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/9] MIPS queue 2018-06-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 June 2018 at 19:29, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 00928a421d47f49691cace1207481b7aad31b1f1:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging (2018-06-26 18:23:49 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu.git tags/mips-queue-2018-06-27
>
> for you to fetch changes up to 8e0b373f8aa4b9feec7b44029455587e2e3d2b0f:
>
>   target/mips: Fix gdbstub to read/write 64 bit FP registers (2018-06-27 20:13:50 +0200)

Applied, thanks.

If you're going to be in the same physical location as other
QEMU or free software/open source developers it's worth arranging
to get your GPG key signed more widely. In particular if you're
going to be at KVM Forum this October let me know.

thanks
-- PMM
