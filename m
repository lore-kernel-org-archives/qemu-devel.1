Received: from eggs.gnu.org ([2001:4830:134:3::10]:45160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMF2H-0001ui-EQ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMF2F-0003Wv-Rp
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:26:01 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:39969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMF2F-0003Ns-6C
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:25:59 -0500
Received: by mail-oi1-x22e.google.com with SMTP id u130-v6so7637925oie.7
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 08:25:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181112151516.10012-1-kraxel@redhat.com>
References: <20181112151516.10012-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 16:25:28 +0000
Message-ID: <CAFEAcA9yhh2g0FjUO6K7VkuH7XhkVCTpgR6xZ9iyRFGw3KB_kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/4] Fixes 31 20181112 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 12 November 2018 at 15:15, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 460f0236c12a86a38692c12d9bf8e2391dc10a=
77:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2018-11-12 10:12:07 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-31-20181112-pull-request
>
> for you to fetch changes up to f1aba960cc40ab65fa88c8678883bd2201708c55:
>
>   ui/gtk: fix cursor in egl mode (2018-11-12 14:15:54 +0100)
>
> ----------------------------------------------------------------
> fixes for 3.1: mark bt as deprecated, bugfixes for pulse, gtk and edid.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (2):
>   pulseaudio: process audio data in smaller chunks
>   ui/gtk: fix cursor in egl mode
>
> Marc-Andr=C3=A9 Lureau (1):
>   edid: silence a stringop-overflow warning
>
> Thomas Huth (1):
>   bt: Mark the bluetooth subsystem as deprecated


Applied, thanks.

-- PMM
