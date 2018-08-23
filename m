Received: from eggs.gnu.org ([2001:4830:134:3::10]:34385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsqU4-0006kJ-N0
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsqU3-0005jS-OJ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:21:12 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:39312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsqU3-0005jD-JM
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:21:11 -0400
Received: by mail-oi0-x232.google.com with SMTP id c190-v6so9549109oig.6
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 07:21:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535033941-861-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 15:20:50 +0100
Message-ID: <CAFEAcA9QQSw9q0Ps6UzMncGM0np9Crk0gs6001qc4f+78v_H0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v5 00/46] MIPS queue August 2018 v5
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

On 23 August 2018 at 15:18, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 3392fbee4e435658733bbe9aab23392660558b59:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-08-23 12:28:17 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-aug-2018
>
> for you to fetch changes up to e7133037c63d9d806f1a1f6c5a1906e658496cfa:
>
>   target/mips: Add definition of nanoMIPS I7200 CPU (2018-08-23 16:11:35 +0200)
>
> ----------------------------------------------------------------
> MIPS queue August 2018 v5
>
> The patches in this queue add support for core functionality and
> system mode for nanoMIPS platform.
>
> v5: Corrected repository
> v4: Fixed clang build errors for user mode configurationos.
> v3: Fixed initial ('since') commit.
> v2: Added missing 'Reviewed-by' lines

Just FYI, if you've made a minor fix to the pullreq you can
just resend the cover letter (and any individual patches
that were significantly affected), you don't need to resend
all 50 emails...

thanks
-- PMM
