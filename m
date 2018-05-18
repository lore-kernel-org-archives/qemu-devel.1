Received: from eggs.gnu.org ([2001:4830:134:3::10]:57599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJfAp-0004kN-Rz
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJfAo-0005Xz-Um
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:11:55 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:45777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJfAo-0005XR-Li
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:11:54 -0400
Received: by mail-ot0-x232.google.com with SMTP id 15-v6so9000055otn.12
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 06:11:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518075015.1290-1-kraxel@redhat.com>
References: <20180518075015.1290-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 14:11:33 +0100
Message-ID: <CAFEAcA9UUvGwJfa8XtxRahK6x=oQFZZAkDw9BBZ9-OwS5b4=2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Usb 20180518 patches
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

On 18 May 2018 at 08:50, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit a4207e3b00e89f934adb231057dcf9a75ac2ae=
45:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-05-17 11:59:50 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180518-pull-request
>
> for you to fetch changes up to 8030dca376fa1bc4d8a6be7628196578f8783ab3:
>
>   hw/usb/dev-smartcard-reader: Handle 64 B USB packets (2018-05-18 09:42:=
16 +0200)
>
> ----------------------------------------------------------------
> usb: two smartcard reader fixes.
>
> ----------------------------------------------------------------
>
> Jakub Jelen (1):
>   hw/usb/dev-smartcard-reader: Handle 64 B USB packets
>
> Marc-Andr=C3=A9 Lureau (1):
>   ccid-card-passthru: fix regression in realize()
>
>  hw/usb/ccid-card-passthru.c   |  2 +-
>  hw/usb/dev-smartcard-reader.c | 14 +++++++++-----
>  2 files changed, 10 insertions(+), 6 deletions(-)

Applied, thanks.

-- PMM
