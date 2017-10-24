Received: from eggs.gnu.org ([2001:4830:134:3::10]:55324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6wzD-00067b-Vz
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6wzD-0007vW-63
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:03:08 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:46107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e6wzC-0007v3-VL
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:03:07 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m72so14927280wmc.1
	for <qemu-devel@nongnu.org>; Tue, 24 Oct 2017 04:03:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171020220533.29186-1-shorne@gmail.com>
References: <20171020220533.29186-1-shorne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Oct 2017 12:02:44 +0100
Message-ID: <CAFEAcA8vO5T1nuOft-i-Z7WkcX3xuyPRvDHt2WTt2tgVCnH3=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/5] OpenRISC SMP Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>

On 20 October 2017 at 23:05, Stafford Horne <shorne@gmail.com> wrote:
> Hello Again,
>
> Please consider for pull.
>
> The following changes since commit e822e81e350825dd94f41ee2538ff1432b812eb9:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-10-20 15:04:00 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stffrdhrn/qemu.git tags/openrisc-20171021-smp-pr
>
> for you to fetch changes up to 373b259b660a8ff0960a979481c19b78d51e023a:
>
>   openrisc: Only kick cpu on timeout, not on update (2017-10-21 06:37:06 +0900)
>
> ----------------------------------------------------------------
> OpenRISC SMP patchset 20171021
>
> ----------------------------------------------------------------
> Stafford Horne (5):
>       openrisc/ompic: Add OpenRISC Multicore PIC (OMPIC)
>       target/openrisc: Make coreid and numcores variable
>       openrisc/cputimer: Perparation for Multicore
>       openrisc: Initial SMP support
>       openrisc: Only kick cpu on timeout, not on update

Applied, thanks.

-- PMM
