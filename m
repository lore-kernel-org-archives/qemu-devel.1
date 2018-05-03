Received: from eggs.gnu.org ([2001:4830:134:3::10]:54976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEDqX-0006QU-Hs
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEDqT-0004Dh-H8
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:00:29 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:41521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEDqS-0004DF-Rk
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:00:24 -0400
Received: by mail-ot0-x229.google.com with SMTP id t1-v6so20491405oth.8
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 06:00:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502174753.16133-1-richard.henderson@linaro.org>
References: <20180502174753.16133-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 14:00:03 +0100
Message-ID: <CAFEAcA9X3GTVVxjKB7Z_Lkm6d0kLw2-p747UAmNeXsh-Z-7TLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] TCG queued patches
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

On 2 May 2018 at 18:47, Richard Henderson <richard.henderson@linaro.org> wrote:
> The first tcg pull for 2.13/3.0.  Two of these are candidates
> for cherry-picking into stable.
>
>
> r~
>
>
> The following changes since commit 26bd8d98c4b3284a4c6fe3b67c98b1edd00e9beb:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.13-pull-request' into staging (2018-05-01 15:26:06 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20180502
>
> for you to fetch changes up to 6001f7729e12dd1d810291e4cbf83cee8e07441d:
>
>   tcg: workaround branch instruction overflow in tcg_out_qemu_ld/st (2018-05-01 11:56:55 -0700)
>
> ----------------------------------------------------------------
> Queued TCG patches
>

Applied, thanks.

-- PMM
