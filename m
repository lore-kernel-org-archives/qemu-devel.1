Received: from eggs.gnu.org ([2001:4830:134:3::10]:58962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1deeAI-0001pr-DC
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1deeAH-0008A5-Cx
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:17:34 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1deeAH-00089A-69
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:17:33 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t201so2214410wmt.1
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 02:17:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170803181224.21748-1-rth@twiddle.net>
References: <20170803181224.21748-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2017 10:17:09 +0100
Message-ID: <CAFEAcA9UP+PZug-i-Pn_0Wq3HobOwXUXaTEYtrwT7Rmh2bjqTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 0/3] TCG misc patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 August 2017 at 19:12, Richard Henderson <rth@twiddle.net> wrote:
> Two of these have been posted before.  The third I discovered in
> testing on a Sparc host yesterday.
>
>
> r~
>
>
> The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519c8:
>
>   Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170803
>
> for you to fetch changes up to 13aaef678ed377b12b76dc7fb9e615b2f2f9047b:
>
>   tcg: Increase minimum alignment from tcg_malloc to 8 (2017-08-03 11:00:30 -0700)
>
> ----------------------------------------------------------------
> Queued misc tcg patches
>
> ----------------------------------------------------------------
> Richard Henderson (3):
>       tcg/arm: Fix runtime overalignment test
>       target/s390x: Fix CSST for 16-byte store
>       tcg: Increase minimum alignment from tcg_malloc to 8
>

Applied, thanks.

-- PMM
