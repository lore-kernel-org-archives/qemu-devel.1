Received: from eggs.gnu.org ([2001:4830:134:3::10]:43834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef5jD-0004LV-IR
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef5j9-0007EM-0O
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:15:43 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:33867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef5j8-0007E7-Rh
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:15:38 -0500
Received: by mail-oi0-x236.google.com with SMTP id k15so514872oib.1
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 07:15:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180126080515.26108-1-kraxel@redhat.com>
References: <20180126080515.26108-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 14:21:01 +0000
Message-ID: <CAFEAcA-SHuK+1tsDLUb0n2fWf8=hyY1o0KQN5euHbKvuCdLfgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Usb 20180126 v3 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 January 2018 at 08:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 2077fef91d5eb8e3745a84fabd87a5ee7d2b535d:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180125' into staging (2018-01-25 17:04:47 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180126-v3-pull-request
>
> for you to fetch changes up to 80ae865468bde918363a123aa26c6fc4385023ac:
>
>   usb-ccid: convert CCIDCardClass::exitfn() -> unrealize() (2018-01-26 07:59:33 +0100)
>
> ----------------------------------------------------------------
> usb: -usbdevice cleanups, storage fix, QOMify ccid.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
