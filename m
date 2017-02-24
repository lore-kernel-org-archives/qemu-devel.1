Received: from eggs.gnu.org ([2001:4830:134:3::10]:34754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGLN-0007aw-Ug
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chGLN-0005sh-7d
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:55:34 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chGLN-0005sM-1J
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:55:33 -0500
Received: by mail-wm0-x233.google.com with SMTP id r141so15115190wmg.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 05:55:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487864414-25485-1-git-send-email-kraxel@redhat.com>
References: <1487864414-25485-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 13:55:11 +0000
Message-ID: <CAFEAcA_S+XKC6xpSxLxRHi3D-KRZ_E0_5XLQART=ktn9eEAtwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] usb patch queue
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

On 23 February 2017 at 15:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> usb patch queue, with cleanups and a ohci fix.
>
> please pull,
>   Gerd
>
> The following changes since commit 796b288f7be875045670f963ce99991b3c8e96=
ac:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2017-02-21 15:48:22 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-usb-20170223-1
>
> for you to fetch changes up to 4f72b8d2a6f5777fa1af2cf5184843e4cb06f182:
>
>   xhci: properties cleanup (2017-02-23 16:18:03 +0100)
>
> ----------------------------------------------------------------
> usb: ohci bugfix, switch core to unrealize, xhci property cleanup
>
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       xhci: properties cleanup
>
> Li Qiang (1):
>       usb: ohci: fix error return code in servicing td
>
> Marc-Andr=C3=A9 Lureau (1):
>       usb: replace handle_destroy with unrealize

Applied, thanks.

-- PMM
