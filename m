Received: from eggs.gnu.org ([209.51.188.92]:34891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gheSo-0008ON-Ae
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:49:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gheSn-0004KS-9V
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:49:54 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:36732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gheSn-0004Jm-4N
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:49:53 -0500
Received: by mail-oi1-x230.google.com with SMTP id x23so9980859oix.3
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20190110084752.30510-1-kraxel@redhat.com>
In-Reply-To: <20190110084752.30510-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jan 2019 17:49:40 +0000
Message-ID: <CAFEAcA8EsZ8RsduQC-+fxi644sMA2KL7bd+p6FZ9Fu=5LHbqww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/8] Ui 20190110 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 10 Jan 2019 at 08:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e59dbbac0364344a3ad84c3497a98c56003d3f=
b8:
>
>   Merge remote-tracking branch 'remotes/philmd/tags/fw_cfg-20190104-pull-=
request' into staging (2019-01-04 18:23:13 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190110-pull-request
>
> for you to fetch changes up to 766a0a54faa97b8d4cbc7a6bd47f7ea78e625c19:
>
>   spice: Remove unused include (2019-01-10 08:55:36 +0100)
>
> ----------------------------------------------------------------
> ui: bugfixes, drop keymap include support, drop dead code.
>
> ----------------------------------------------------------------
>
> Frediano Ziglio (1):
>   spice: Remove unused include
>
> Gerd Hoffmann (5):
>   egl-headless: add egl_create_context
>   keymaps: remove modifiers include
>   keymaps: drop nl-be map
>   keymaps: remove common include
>   keymaps: drop support for include files
>
> Marc-Andr=C3=A9 Lureau (1):
>   configure: bump spice-server required version to 0.12.5
>
> Peter Maydell (1):
>   ui/console: Remove qemu_create_display_surface_guestmem()

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes. (In particular we have a section
for changes in the required versions of dependent libraries etc).

-- PMM
