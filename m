Received: from eggs.gnu.org ([209.51.188.92]:37452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn5Uc-0008Hg-CY
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn5Ub-0003sQ-Ah
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:42:14 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:42827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn5Ua-0003rW-T0
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:42:13 -0500
Received: by mail-oi1-x235.google.com with SMTP id w13so8235264oiw.9
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 09:42:12 -0800 (PST)
MIME-Version: 1.0
References: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548423098-31864-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 17:22:00 +0000
Message-ID: <CAFEAcA-yAMQDNvTJF=EQCfqQB7BRYNVixESYd4tXxQuHLqYVYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] MIPS queue for January 25, 2019
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

On Fri, 25 Jan 2019 at 13:31, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 8b7a3e1e5434b55d7710071b00af97c7086cab7a:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-01-24 15:04:47 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-january-25-2019
>
> for you to fetch changes up to e5a5b1bb7cfa2da3762f947003cba6a16fa242a1:
>
>   docs/qemu-cpu-models: Add MIPS/nanoMIPS QEMU supported CPU models (2019-01-24 17:48:33 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for January 25, 2019:
>
>   - reorganization of MIPS TCG tests directories and files
>   - documentation updates for MIPS
>   - enabling I6500 core support
>   - other misc MIPS fixes
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
