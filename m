Received: from eggs.gnu.org ([2001:4830:134:3::10]:43548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO6Qk-0002ZQ-K3
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO6Qj-000703-Mx
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:02:10 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dO6Qj-0006zt-Ek
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 14:02:09 -0400
Received: by mail-wr0-x22d.google.com with SMTP id c11so33625116wrc.3
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 11:02:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170621154347.32084-1-kraxel@redhat.com>
References: <20170621154347.32084-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 19:01:47 +0100
Message-ID: <CAFEAcA__PkPNfKUoRBvt1CJ-Y3z8ChDreN+MkX1CfngVdydZUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Usb 20170621 patches
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

On 21 June 2017 at 16:43, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 8dfaf23ae1f2273a9730a9b309cc8471269bb524:
>
>   tcg/tci: fix tcg-interpreter build (2017-06-20 18:39:15 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20170621-pull-request
>
> for you to fetch changes up to 896b6757f9c4d176ce4439238efea223a2952411:
>
>   usb-host: support devices with sparse/non-sequential USB interfaces (2017-06-21 15:30:08 +0200)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Samuel Brian (1):
>   usb-host: support devices with sparse/non-sequential USB interfaces
>
>  hw/usb/host-libusb.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

Applied, thanks.

-- PMM
