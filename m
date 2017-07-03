Received: from eggs.gnu.org ([2001:4830:134:3::10]:56973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRyGT-00076z-Ji
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRyGS-0007J1-TR
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:07:33 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:33919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dRyGS-0007Ix-N3
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:07:32 -0400
Received: by mail-wm0-x233.google.com with SMTP id 70so17841179wmo.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 03:07:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170630190903.9886-1-rth@twiddle.net>
References: <20170630190903.9886-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jul 2017 11:07:11 +0100
Message-ID: <CAFEAcA-1ZebkV5MZdFyngDKa5ZD+MOsf7KBj0TiUPQcdzwhrHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Queued TCG patches
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

On 30 June 2017 at 20:09, Richard Henderson <rth@twiddle.net> wrote:
> None of my TCGTemp patches for now; I'm still trying to understand
> how they might (or might not) conflict with multi-threaded code gen
> for TCG.
>
>
> r~
>
>
> The following changes since commit 82d76dc7fc19a5eb9f731d7faed1792bb97214e0:
>
>   Merge remote-tracking branch 'remotes/famz/tags/block-pull-request' into staging (2017-06-30 16:29:51 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170603
>
> for you to fetch changes up to f3ced3c59287dabc253f83f0c70aa4934470c15e:
>
>   tcg: consistently access cpu->tb_jmp_cache atomically (2017-06-30 11:40:59 -0700)
>
> ----------------------------------------------------------------
> Queued TCG patches
>

Applied, thanks.

-- PMM
