Received: from eggs.gnu.org ([209.51.188.92]:57889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxAVx-0006xD-EU
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxAVt-0002Si-4D
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:05:15 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:34267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxAVr-0001PM-Vq
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:05:12 -0500
Received: by mail-ot1-x32c.google.com with SMTP id 98so1804186oty.1
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 05:04:35 -0800 (PST)
MIME-Version: 1.0
References: <1550775220-26797-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550775220-26797-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 13:04:23 +0000
Message-ID: <CAFEAcA-QKix1SOOOepRZNxRbROhSVv+E+M6D5U0g=m3AX-abJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/8] MIPS queue for February 21st, 2019,
 v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 21 Feb 2019 at 18:53, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-feb-21-2019-v2
>
> for you to fetch changes up to fb1b0fcc03b0c15bc3580309738280ad9565b6d9:
>
>   target/mips: fulong2e: Dynamically generate SPD EEPROM data (2019-02-21 19:36:47 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for February 21st, 2019, v2
>
>   - fix 32/64 bit issue with a shift operator in MIPS ITU code
>   - fix three misc issues in tcg tests code for MIPS
>   - add QMP query-cpu-definitions command for MIPS
>   - improve MIPS Fulong 2E machine
>
> NOTE: There is a checkpatch warning (about updating MAINTAINERS)
> that should be ignored for given circumstances.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
