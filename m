Received: from eggs.gnu.org ([2001:4830:134:3::10]:52632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4UaL-0003wC-2x
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f4UaK-0000vy-Cp
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:51:33 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:34538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f4UaK-0000vp-6I
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:51:32 -0400
Received: by mail-ot0-x234.google.com with SMTP id m7-v6so1873472otd.1
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 09:51:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180406131832.23901-1-richard.henderson@linaro.org>
References: <20180406131832.23901-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Apr 2018 17:51:10 +0100
Message-ID: <CAFEAcA8+E9L_NnYUUqnUckto5YB3q728nH=JO5kiy34md14UpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.12 0/1] target/hppa: seabios-hppa
 update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, deller@gmx.de

On 6 April 2018 at 14:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Helge Deller has fixed some bios bugs and has asked
> that I update qemu thus.
>
>
> r~
>
>
> The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:
>
>   Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-hppa-20180407
>
> for you to fetch changes up to 5aa48600823a1fc2f5c8c3ec3e93227d4638e3a4:
>
>   Update seabios-hppa (2018-04-06 23:14:51 +1000)
>
> ----------------------------------------------------------------
> Update hppa-softmmu bios
>
> ----------------------------------------------------------------
> Richard Henderson (1):
>       Update seabios-hppa
>
>  pc-bios/hppa-firmware.img | Bin 215696 -> 215936 bytes
>  roms/seabios-hppa         |   2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- PMM
