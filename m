Received: from eggs.gnu.org ([2001:4830:134:3::10]:60627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTT6f-0003rj-Dz
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTT6e-0000tk-LG
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:20:09 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTT6e-0000tR-7i
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:20:08 -0400
Received: by mail-ot0-x244.google.com with SMTP id l15-v6so7264007oth.6
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 07:20:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180614083258.14618-1-kraxel@redhat.com>
References: <20180614083258.14618-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 15:19:47 +0100
Message-ID: <CAFEAcA9Z1_2QpsbJLR3Z6eOnO1o0Hu2V1B7GzMB8mxU337OCGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Ui 20180614 patches
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

On 14 June 2018 at 09:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268=
e2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-req=
uest' into staging (2018-06-12 15:34:34 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180614-pull-request
>
> for you to fetch changes up to 64bf97e56f3ab44d587c92c40503d646273a24df:
>
>   sdl2: restore window dimensions by resize (2018-06-14 09:55:09 +0200)
>
> ----------------------------------------------------------------
> ui: bugfixes for sdl and gtk
>
> ----------------------------------------------------------------
>
> Amadeusz S=C5=82awi=C5=84ski (1):
>   sdl2: restore window dimensions by resize
>
> Keno Fischer (1):
>   ui: darwin: gtk: Add missing input keymap
>
>  Makefile           | 1 +
>  include/ui/input.h | 3 +++
>  ui/input-keymap.c  | 1 +
>  ui/sdl2.c          | 3 +--
>  4 files changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
