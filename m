Received: from eggs.gnu.org ([209.51.188.92]:35688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggplp-0003a0-BK
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggpln-0007Uf-DQ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:42:09 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:37791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggpll-0007KP-Mt
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:42:07 -0500
Received: by mail-ot1-x329.google.com with SMTP id 40so3205572oth.4
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 03:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20190108021723.14762-1-richard.henderson@linaro.org>
In-Reply-To: <20190108021723.14762-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 11:41:50 +0000
Message-ID: <CAFEAcA8+HfKVV65wCpfjY7pW3o7DJ4reFejZ0pHvex+zmEczdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] target/alpha update
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

On Tue, 8 Jan 2019 at 02:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> One quite old queued patch, and two recent bug fixes.
>
>
> r~
>
>
> The following changes since commit c102d9471f8f02d9fbea72ec4505d7089173f470:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190107' into staging (2019-01-07 16:56:33 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-axp-20190108
>
> for you to fetch changes up to ac89de40ef5d4eb1704aa830342a5371413a81dc:
>
>   pc-bios: Update palcode-clipper (2019-01-08 12:12:51 +1000)
>
> ----------------------------------------------------------------
> Queued target/alpha patches
>
> ----------------------------------------------------------------
> Peter Maydell (1):
>       hw/alpha/typhoon: Stop calling cpu_unassigned_access()
>
> Richard Henderson (2):
>       target/alpha: Fix user-only initialization of fpcr
>       pc-bios: Update palcode-clipper

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
