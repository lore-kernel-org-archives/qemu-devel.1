Received: from eggs.gnu.org ([2001:4830:134:3::10]:47875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6zR1-0001B1-06
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6zR0-0008Mg-Be
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:44:30 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:39281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g6zQz-0008Lg-RU
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:44:30 -0400
Received: by mail-oi1-x22a.google.com with SMTP id y81-v6so11382177oia.6
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 07:44:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001092848.11082-1-kraxel@redhat.com>
References: <20181001092848.11082-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Oct 2018 15:44:07 +0100
Message-ID: <CAFEAcA-+=eLwGvDaZGm8xUA-ttnt8ucS64AecrUfwyYi+9vM_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Usb 20181001 patches
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

On 1 October 2018 at 10:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 07f426c35eddd79388a23d11cb278600d7e3831d:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180926' into staging (2018-09-28 18:56:09 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20181001-pull-request
>
> for you to fetch changes up to a60f39a4681b369bdcc78a9d1a1067d4a6bb8736:
>
>   ohci: set effectively usb frame rate to 1kHz (2018-10-01 10:49:54 +0200)
>
> ----------------------------------------------------------------
> usb: fixes for mtp, hub and ohci.
>
Applied, thanks.

-- PMM
