Received: from eggs.gnu.org ([2001:4830:134:3::10]:47174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHSjk-0005nZ-TS
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHSjf-0006tY-2i
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:03:08 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:41771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHSjb-0006ig-15
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:03:01 -0400
Received: by mail-ot1-x32b.google.com with SMTP id c32so10779295otb.8
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:02:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 12:02:25 +0000
Message-ID: <CAFEAcA_yLPivG+VvQSpLrqxPgJixYWf=xfc95abDgT45hQR8eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] MIPS queue for October 2018, part 4
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

On 29 October 2018 at 15:19, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 03f400883a1dd92fac5b0d9127b38e34c9a722d7:
>
>   target/mips: Add MXU decoding engine (2018-10-29 14:13:47 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-october-2018-part-4
>
> for you to fetch changes up to 64ea3d676d9447ecdb987deab5a1542ea088bd31:
>
>   linux-user: Add prctl() PR_SET_FP_MODE and PR_GET_FP_MODE implementations (2018-10-29 15:50:31 +0100)
>
> ----------------------------------------------------------------
> MIPS queue for October 2018, part 4
>
>   - fix for two missing break statements
>   - series on Ingenic's MXU ASE support
>   - series on MIPS-specific prctl()
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
