Received: from eggs.gnu.org ([209.51.188.92]:50880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghuQY-0002cz-Sp
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghuQX-0004Jf-Nx
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:52:38 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:43007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghuQX-0004Dl-EC
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:52:37 -0500
Received: by mail-oi1-x22e.google.com with SMTP id w13so11824539oiw.9
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 02:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20190110092355.7121-1-kraxel@redhat.com>
In-Reply-To: <20190110092355.7121-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 10:52:15 +0000
Message-ID: <CAFEAcA-bwQgxbz5zDvGrYXHvNRUXpNKp4ni8Zt9dJDPZxk=iOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Audio 20190110 patches
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

On Thu, 10 Jan 2019 at 09:25, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e59dbbac0364344a3ad84c3497a98c56003d3fb8:
>
>   Merge remote-tracking branch 'remotes/philmd/tags/fw_cfg-20190104-pull-request' into staging (2019-01-04 18:23:13 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20190110-pull-request
>
> for you to fetch changes up to a7fde1c1706a93c304eb301cc290d71c9426493b:
>
>   usb-audio: ignore usb packages with wrong size (2019-01-10 09:56:19 +0100)
>
> ----------------------------------------------------------------
> audio: two fixes.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   usb-audio: ignore usb packages with wrong size
>
> Thomas Huth (1):
>   hw/audio/marvell: Don't include unnecessary i2c.h header file

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
