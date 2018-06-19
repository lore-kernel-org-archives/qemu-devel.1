Received: from eggs.gnu.org ([2001:4830:134:3::10]:58364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVJiW-0003cV-SE
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVJiV-00027V-Jf
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:42:52 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:37187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVJiV-00026t-Ex
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:42:51 -0400
Received: by mail-oi0-x234.google.com with SMTP id l22-v6so327387oib.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:42:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618164955.6923-1-richard.henderson@linaro.org>
References: <20180618164955.6923-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 17:42:30 +0100
Message-ID: <CAFEAcA9kArDaoj_VMdAawhoXGawRPrSQfYO2qH7Gx_buUbqtWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] alpha-softmmu queue
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

On 18 June 2018 at 17:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799f=
a2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-axp-20180618
>
> for you to fetch changes up to 75cacb128b2d39863a72f60cbefc0987cbcaf641:
>
>   hw/isa/smc37c669: Change the parallel I/O base to 378H (2018-06-16 19:4=
6:54 -1000)
>
> ----------------------------------------------------------------
> Place parallel device properly, fixing vga
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (1):
>       hw/isa/smc37c669: Change the parallel I/O base to 378H
>
>  hw/isa/smc37c669-superio.c | 2 +-

Applied, thanks.

-- PMM
