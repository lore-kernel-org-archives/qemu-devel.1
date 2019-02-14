Received: from eggs.gnu.org ([209.51.188.92]:54489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guIqQ-0007Br-Rj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guIqQ-000145-0m
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:22:34 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:33459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guIqM-0000zH-Oo
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:22:32 -0500
Received: by mail-ot1-x32b.google.com with SMTP id i20so11128832otl.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 07:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 15:22:13 +0000
Message-ID: <CAFEAcA_iU-k+SOFbKe7qSPSOGtE+AWtoy2NUqTidoe59so0dwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/25] Chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 13 Feb 2019 at 16:19, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc=
06:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-02-12 10:53:37 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/chardev-pull-request
>
> for you to fetch changes up to f7ea2038bea04628eaa55156fc34edf9d0c4a2bb:
>
>   char-pty: remove write_lock usage (2019-02-13 16:46:39 +0100)
>
> ----------------------------------------------------------------
> Chardev fixes
>
> ----------------------------------------------------------------
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
