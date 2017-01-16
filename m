Received: from eggs.gnu.org ([2001:4830:134:3::10]:55793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT6bX-0008Co-Fp
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT6bW-0001js-NK
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:41:43 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cT6bW-0001jZ-I7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 07:41:42 -0500
Received: by mail-ua0-x22a.google.com with SMTP id 35so80318535uak.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 04:41:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170113200556.2574-1-rth@twiddle.net>
References: <20170113200556.2574-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 12:41:21 +0000
Message-ID: <CAFEAcA_kui8Ah-9_1Y1F_TwmoAO5HAMNoz+XHzvxeFBhKnXxGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] tcg fixes
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

On 13 January 2017 at 20:05, Richard Henderson <rth@twiddle.net> wrote:
> Two problems found with my most recent tcg-2.9 queued patches;
> two patches for tcg/aarch64 that had been submitted but somehow
> dropped off the patch queue.
>
> With this, aarch64 risu passes on aarch64 again.
>
>
> r~
>
>
> The following changes since commit b6af8ea60282df514f87d32e36afd1c9aeee28c8:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-01-13 14:38:21 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170113
>
> for you to fetch changes up to 8cf9a3d3f7a4b95f33e0bda5416b9c93ec887dd3:
>
>   tcg/aarch64: Fix tcg_out_movi (2017-01-13 11:47:29 -0800)
>
> ----------------------------------------------------------------
> Fixes and more queued patches
>

Applied, thanks.

-- PMM
