Received: from eggs.gnu.org ([2001:4830:134:3::10]:46755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYVqI-0005XM-3S
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 07:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYVqG-0001J7-23
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 07:48:21 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYVqF-0001IG-9n
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 07:48:19 -0500
Received: by mail-ot1-x335.google.com with SMTP id t5so9770117otk.1
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 04:48:19 -0800 (PST)
MIME-Version: 1.0
References: <20181214103854.13820-1-kraxel@redhat.com>
In-Reply-To: <20181214103854.13820-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Dec 2018 12:48:07 +0000
Message-ID: <CAFEAcA9vmy-z9me-Sm6a2Oyrb+_Lt5MpMvWKWSUhYEMcJBPk4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Usb 20181214 patches
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

On Fri, 14 Dec 2018 at 10:44, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 4f818e7b7f8ecb5c166d093b8859fec2ddeca2ef:
>
>   Update version for v3.1.0-rc5 release (2018-12-06 17:07:12 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20181214-pull-request
>
> for you to fetch changes up to 90c1a74271ce4667d16eeca575dfa78a6c7d465c:
>
>   usb-mtp: Limit filename to object information size (2018-12-14 08:57:17 +0100)
>
> ----------------------------------------------------------------
> usb: fixes for mtp, ehci, usb-host and pvusb (xen).
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
