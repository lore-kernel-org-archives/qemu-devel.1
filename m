Received: from eggs.gnu.org ([2001:4830:134:3::10]:38502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRhkk-00056B-8x
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRhkh-0002yZ-L7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:57:26 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:34915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRhkh-0002yQ-8I
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:57:23 -0500
Received: by mail-ua0-x22a.google.com with SMTP id y9so17252725uae.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 07:57:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 15:57:02 +0000
Message-ID: <CAFEAcA8=i+u7uyTNWQAnEKeGDUvJge2ZsRTfj_i2b19i=dmD3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/65] tcg 2.9 patch queue
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

On 11 January 2017 at 02:17, Richard Henderson <rth@twiddle.net> wrote:
> There are minimal changes since v5, mostly to handle conflicts
> with the tcg mips64 patch set merged a few days ago.
>
> Thanks to Alex for reviewing the arm bits; and to Mark, Bastian,
> David, and Yongbok for reviews of their respective cpus.
>
>
> r~
>
>
> The following changes since commit 41a0e54756a9ae6b60be34bb33302a7e085fdb07:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-01-10 10:46:21 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170110
>
> for you to fetch changes up to 993508e43e6d180e9ba9b747a9657eac69aec5bb:
>
>   tcg/i386: Handle ctpop opcode (2017-01-10 08:49:59 -0800)
>
> ----------------------------------------------------------------
> TCG opcodes for extract, clz, ctz, ctpop

Applied, thanks.

-- PMM
