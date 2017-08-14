Received: from eggs.gnu.org ([2001:4830:134:3::10]:45194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhEbL-0001LW-0O
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhEbK-0002Iu-4x
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:36:11 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhEbJ-0002IJ-Un
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:36:10 -0400
Received: by mail-wr0-x236.google.com with SMTP id l9so11394670wrl.1
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 05:36:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Aug 2017 13:35:48 +0100
Message-ID: <CAFEAcA-AwJBev+SDuKz129+0WBvAP2wefzn2p7jwu-bCTjoFUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Trivial patches for 2017-08-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 14 August 2017 at 12:07, Michael Tokarev <mjt@tls.msk.ru> wrote:
> There are just a few small thigs, I've omitted larger series for now.
>
> The following changes since commit 9db6ffc76676731a25a5538ab71e8ca6ac234f80:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-08-11 15:11:50 +0100)
>
> are available in the git repository at:
>
>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>
> for you to fetch changes up to a808c0865b720e22ca2929ec3d362d4610fbad51:
>
>   hw/misc/mmio_interface: Return after error_setg() to avoid crash (2017-08-14 13:06:54 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2017-08-14
>
> ----------------------------------------------------------------
> Cleber Rosa (3):
>       qemu-iotests: get rid of _full_imgproto_details()
>       qemu-iotests: remove commented out variables
>       qemu-iotests: remove comment about root privileges requirement
>
> Eduardo Otubo (1):
>       unicore32: abort when entering "x 0" on the monitor
>
> Eric Blake (1):
>       libqtest: Fix typo in comments
>
> Thomas Huth (2):
>       qemu-doc: Fix "-net van" typo
>       hw/misc/mmio_interface: Return after error_setg() to avoid crash

Applied, thanks.

-- PMM
