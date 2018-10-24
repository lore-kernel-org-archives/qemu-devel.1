Received: from eggs.gnu.org ([2001:4830:134:3::10]:46328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFNbW-0004Y0-CB
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFNP9-00022k-0H
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:57:16 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:39917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFNP8-00021h-N9
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:57:14 -0400
Received: by mail-ot1-x332.google.com with SMTP id a18so5941419otl.6
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 10:57:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Oct 2018 18:56:53 +0100
Message-ID: <CAFEAcA-XiRBFYPSGgreq6m6F7Hdk4fOKTCO2UQKiDz3FZgqKOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/33] MIPS queue for October 2018 - part
 2 - v2
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

On 24 October 2018 at 14:40, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966ba3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22' into staging (2018-10-23 17:20:23 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-2-v2
>
> for you to fetch changes up to 373ecd3823f949fd550ec49685299e287af5753e:
>
>   target/mips: Fix decoding of ALIGN and DALIGN instructions (2018-10-24 15:20:32 +0200)
>
> ----------------------------------------------------------------
> MIPS queue for October 2018 - part 2 - v2
>
> v1->v2:
>   - disassembler for R5900 feature removed (one whole patch and
>       parts of several other patches are excluded)
>   - amended R5900 CPU definition with respect to ASE_MMI
>   - minor improvements of patch titles, commit messages and comments
>
> ----------------------------------------------------------------
>
Applied, thanks.

-- PMM
