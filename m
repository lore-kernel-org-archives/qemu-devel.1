Received: from eggs.gnu.org ([209.51.188.92]:42658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glf6f-0001M8-CH
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glf6e-0001hv-Is
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:19:37 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:39935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glf6e-0001fe-EI
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:19:36 -0500
Received: by mail-ot1-x32a.google.com with SMTP id n8so21484487otl.6
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 11:19:32 -0800 (PST)
MIME-Version: 1.0
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 19:19:19 +0000
Message-ID: <CAFEAcA_6OHyo6i-jO-ff1=41t4oZSe4LnMN4FtyqkhTEonhhFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/12] MIPS queue for January 17,
 2019 - v2
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

On Fri, 18 Jan 2019 at 16:59, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 681d61362d3f766a00806b89d6581869041f73cb:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-01-17 12:48:42 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-january-17-2019-v2
>
> for you to fetch changes up to a168a796e1c251787fcdf2d9ca1e9e69cb86ffcd:
>
>   target/mips: Introduce 32 R5900 multimedia registers (2019-01-18 16:53:28 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for January 17, 2019 - v2
>
> v1->v2:
>   - fixed "make check" error
>
> content:
>   - provide access to configuration registers SAARI, SAAR, and
>     MemoryMapID
>   - update Inter-Thread Communication Unit
>   - CP0-related cleanups
>   - introduce R5900 multimedia registers
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
