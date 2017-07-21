Received: from eggs.gnu.org ([2001:4830:134:3::10]:49140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYUHg-0000Fx-MY
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYUHf-0006qN-U3
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:31:44 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYUHf-0006oz-Ng
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:31:43 -0400
Received: by mail-wm0-x234.google.com with SMTP id w191so3773258wmw.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:31:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170720084522.28616-1-kraxel@redhat.com>
References: <20170720084522.28616-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 10:31:22 +0100
Message-ID: <CAFEAcA900s4Y5SS=8Yvh8dSf6RfAe97ZxAA37-ad=W=ujvhmig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Usb 20170720 patches
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

On 20 July 2017 at 09:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit d4e59218ab80e86015753782fb5378767a51ccd0:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-07-18-2' into staging (2017-07-19 20:45:37 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20170720-pull-request
>
> for you to fetch changes up to 121829cb2160e9cd82482c1542699fa589688106:
>
>   usb: Fix build with newer gcc (2017-07-20 10:02:11 +0200)
>
> ----------------------------------------------------------------
> usb: Fix build with newer gcc
>
> ----------------------------------------------------------------
>
> Eric Blake (1):
>   usb: Fix build with newer gcc
>
>  hw/usb/bus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
