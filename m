Received: from eggs.gnu.org ([2001:4830:134:3::10]:39768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIbV5-0003fK-Oi
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIbV4-00069L-Uw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:59:55 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIbV4-000693-N2
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:59:54 -0400
Received: by mail-wm0-x22c.google.com with SMTP id n195so11892839wmg.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 06:59:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607093027.14086-1-laurent@vivier.eu>
References: <20170607093027.14086-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 14:59:32 +0100
Message-ID: <CAFEAcA8FgZLZrTnyPHUaCPiaQFQ+r33HLdyB7eC=OhzpDybRGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] M68k for 2.10 patches
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

On 7 June 2017 at 10:30, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 65dfad62a176f5265f801683be64149c5ad55f7d:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20170606-xtensa' into staging (2017-06-06 17:00:12 +0100)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.10-pull-request
>
> for you to fetch changes up to 18059c9e1648bf4fc5c7c1bae6f54690742b05ba:
>
>   target/m68k: implement rtd (2017-06-07 11:18:30 +0200)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Laurent Vivier (1):
>   target/m68k: implement rtd
>
>  target/m68k/cpu.c       |  2 ++
>  target/m68k/cpu.h       |  1 +
>  target/m68k/translate.c | 11 +++++++++++
>  3 files changed, 14 insertions(+)

Applied, thanks.

-- PMM
