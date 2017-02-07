Received: from eggs.gnu.org ([2001:4830:134:3::10]:36910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb7i4-0004fN-WB
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb7i3-0008P8-Vq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:29:37 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb7i3-0008Ow-Q0
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:29:35 -0500
Received: by mail-wr0-x235.google.com with SMTP id 89so40948812wrr.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 07:29:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170207023229.29431-1-rth@twiddle.net>
References: <20170207023229.29431-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 15:29:14 +0000
Message-ID: <CAFEAcA8=mwGoNn070RiCwDgHacO_VU6KZbyv9qb6E65UO=2CGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] target/hppa patch queue
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

On 7 February 2017 at 02:32, Richard Henderson <rth@twiddle.net> wrote:
> Nothing complicated here.  Two bugs from Laurent, two noticed
> by Coverity (through multiple channels).
>
>
> r~
>
>
>
> The following changes since commit 7d2c6c95511e42dffe2b263275e09957723d0ff4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170206-1' into staging (2017-02-06 11:44:08 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-hppa-20170206
>
> for you to fetch changes up to 6836a8fb96963a29f309d49873062bbca9ab0e28:
>
>   target/hppa: Fix gdb_write_register (2017-02-06 18:25:31 -0800)
>
> ----------------------------------------------------------------
> Misc hppa fixes.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
