Received: from eggs.gnu.org ([2001:4830:134:3::10]:48566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDRtQ-00035D-3o
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDRtP-00021T-7j
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:20:32 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:42157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDRtN-0001mc-Be
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:20:31 -0400
Received: by mail-ot1-x32b.google.com with SMTP id c23so30900498otl.9
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:20:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 11:19:50 +0100
Message-ID: <CAFEAcA-Bve7UiXpLsqw7fwg5o7rUP_btyS+KVb_=7hfwQnLWfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/28] MIPS queue October 2018, part 1, v2
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

On 18 October 2018 at 19:47, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 77f7c747193662edfadeeb3118d63eed0eac51a6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-10-17' into staging (2018-10-18 13:40:19 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-october-2018-part1-v2
>
> for you to fetch changes up to 0d30b3bbc5fed12da8f8d1bfd28f2803d65a4cb0:
>
>   target/mips: Add opcodes for nanoMIPS EVA instructions (2018-10-18 20:37:20 +0200)
>
> ----------------------------------------------------------------
> MIPS queue October 2018, part1, v2
>
> v1->v2:
> - fixed clang build error
> - a small patch forgotten in v1 included now
> - MXU patches slightly improved (fixed typos etc.)
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
