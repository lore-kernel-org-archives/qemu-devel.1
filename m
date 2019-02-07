Received: from eggs.gnu.org ([209.51.188.92]:33888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grkY1-0007iQ-WA
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grkY0-0008RD-Hs
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:21:01 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:35439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grkXz-0008EC-Nc
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:20:59 -0500
Received: by mail-ot1-x335.google.com with SMTP id 81so36742otj.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 06:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20190206105337.11559-1-richard.henderson@linaro.org>
In-Reply-To: <20190206105337.11559-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 14:20:27 +0000
Message-ID: <CAFEAcA8KjkrNu3KS8-TLfExOOb_zsniXETjgZg3QRa2yNgF_HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] target/hppa queued patches
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

On Wed, 6 Feb 2019 at 10:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> One of these, unfortunately, got lost on a local branch for a year.  ;-P
>
>
> r~
>
>
> The following changes since commit 47994e16b1d66411953623e7c0bf0cdcd50bd507:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190205' into staging (2019-02-05 18:25:07 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190206
>
> for you to fetch changes up to 68aa851aa21741ab0a3c019b641d6ce72f68b3d5:
>
>   target/hppa: fix PSW Q bit behaviour to match hardware (2019-02-06 10:49:21 +0000)
>
> ----------------------------------------------------------------
> Queued target/hppa patches
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
