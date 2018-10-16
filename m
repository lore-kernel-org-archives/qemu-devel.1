Received: from eggs.gnu.org ([208.118.235.92]:42297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCKrM-0000qQ-A8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCKZ5-0004sN-Px
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:19:45 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:45028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCKZ4-0004ly-GV
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 04:18:55 -0400
Received: by mail-ot1-x331.google.com with SMTP id p23so21626431otf.11
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 01:18:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <153962488126.21502.17134983449941187881.stgit@gimli.home>
References: <153962488126.21502.17134983449941187881.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 09:18:30 +0100
Message-ID: <CAFEAcA_sH5OC45GftQqRGoyzDuVQZ7z-kVvviui9usyMqBXbww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] vfio updates 2018-10-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Li Qiang <liq3ea@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>

On 15 October 2018 at 18:36, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit ff56877e911782dedc9a424233fd3f62369c258c:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20181015-pull-request' into staging (2018-10-15 15:03:45 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20181015.0
>
> for you to fetch changes up to 2683ccd5be8f4bad197aa95bf29154640519f4c2:
>
>   vfio-pci: make vfio-pci device more QOM conventional (2018-10-15 11:22:29 -0600)
>
> ----------------------------------------------------------------
> VFIO updates 2018-10-15
>
>  - ramfb support for vfio-pci via new -nohotplug device variant
>    (Gerd Hoffmann)
>
>  - Preparation for generic DT pass-through in vfio-platform
>    (Geert Uytterhoeven & Eric Auger)
>
>  - vfio-pci QOM fixups (Li Qiang)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
