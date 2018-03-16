Received: from eggs.gnu.org ([2001:4830:134:3::10]:47555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewtoE-0007Qi-LZ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewtoD-0002sk-LY
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:10:30 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:43526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewtoD-0002rA-Fp
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:10:29 -0400
Received: by mail-oi0-x22b.google.com with SMTP id y27so5148968oix.10
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:10:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180315173855.22456-1-richard.henderson@linaro.org>
References: <20180315173855.22456-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 18:10:08 +0000
Message-ID: <CAFEAcA8mAuUoSmUcN9nJfEtv1s2CcGz91oDOajwYsCe1w9uEHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/3] tcg queued patches
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

On 15 March 2018 at 17:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Ho hum, I rushed v1 before leaving on holidays and failed to format
> the cover letter properly, so Peter's scripts did not pick it up.
>
> Patches 2 & 3 are real bug fixes and so still appropriate for the
> softfreeze.  Patch 1 is trivial enough I didn't feel it needed to
> be held back for 2.13 development.  Let me know if you disagree.
>
>
> r~
>
>
> The following changes since commit 56e8698ffa8aba9f762f980bc21b5340b006f24b:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-130318-1' into staging (2018-03-15 14:48:09 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20180316
>
> for you to fetch changes up to adb196cbd5cff26547bc32a208074f03f4c4a627:
>
>   tcg: Add choose_vector_size (2018-03-16 00:55:04 +0800)
>
> ----------------------------------------------------------------
> Queued TCG patches
>
> ----------------------------------------------------------------
> Richard Henderson (3):
>       tcg: Improve tcg_gen_muli_i32/i64
>       tcg/i386: Support INDEX_op_dup2_vec for -m32
>       tcg: Add choose_vector_size

Applied, thanks.

-- PMM
