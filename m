Received: from eggs.gnu.org ([209.51.188.92]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPYv-0005xR-MG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLPYu-00082Q-2C
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:00:33 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:35857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLPYt-00081h-QQ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:00:32 -0400
Received: by mail-oi1-x22c.google.com with SMTP id l203so10766918oia.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190429215821.10079-1-richard.henderson@linaro.org>
In-Reply-To: <20190429215821.10079-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 11:00:19 +0100
Message-ID: <CAFEAcA9S21wftfXwLV5T3bX2p=R4RnMkpWvxqTA1su4QvoZb7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/2] target/hppa patch queue
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

On Mon, 29 Apr 2019 at 22:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rebased for v2.
>
> The following changes since commit 82b2865e0d0ea4c1001e9e7ed7920bcc0458f6de:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190429' into staging (2019-04-29 18:05:56 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190429
>
> for you to fetch changes up to affdb7e6ba23f8160cb88e11f83db54a35f03d6b:
>
>   target/hppa: Always return EXCP_DMAR for protection id trap (2019-04-29 14:43:39 -0700)
>
> ----------------------------------------------------------------
> Implement fast tlb insert insns.
> Fix data tlb exception for pa 1.1.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
