Received: from eggs.gnu.org ([2001:4830:134:3::10]:59530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1estB0-0002QR-5n
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1estAz-0005Tm-CC
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:41:26 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:40037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1estAz-0005Sw-7A
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:41:25 -0500
Received: by mail-ot0-x233.google.com with SMTP id l12so15498580otj.7
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 08:41:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305084844.18222-1-kraxel@redhat.com>
References: <20180305084844.18222-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 16:41:04 +0000
Message-ID: <CAFEAcA_s9nhwbaYa2ag6F=G9YZizvphaK0P4mxiqj_a=-CA0Tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] Ui 20180305 patches
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

On 5 March 2018 at 08:48, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 136c67e07869227b21b3f627316e03679ce7b738:
>
>   Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-2018-03-02' into staging (2018-03-02 16:56:20 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180305-pull-request
>
> for you to fetch changes up to 96400a148b3e1337e2c451e95bc3c3c69a05b67c:
>
>   ui/sdl: build as module (2018-03-05 08:44:11 +0100)
>
> ----------------------------------------------------------------
> ui: build curses, gtk and sdl as modules.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
