Received: from eggs.gnu.org ([209.51.188.92]:33572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyFgy-0007w2-Tr
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyFgy-0004Ah-11
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:49:08 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:45218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyFgx-00045W-9w
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:49:07 -0500
Received: by mail-oi1-x234.google.com with SMTP id t82so7074162oie.12
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 04:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20190222075326.9850-1-kraxel@redhat.com>
In-Reply-To: <20190222075326.9850-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 12:48:55 +0000
Message-ID: <CAFEAcA9gFHdVKaDRrZuG3Qg+Pyago52cOcsFuXMCcHwxO1t+3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] Ui 20190222 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Fri, 22 Feb 2019 at 07:55, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 2e68b8620637a4ee8c79b5724144b726af1e261b:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190219' into staging (2019-02-18 16:20:13 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190222-pull-request
>
> for you to fetch changes up to d8aec9d9f129e6879ae0669623981892deff86f2:
>
>   display: add -display spice-app launching a Spice client (2019-02-22 07:42:59 +0100)
>
> ----------------------------------------------------------------
> ui: add support for -display spice-app
> ui: gtk+sdl bugfixes.
>
> ----------------------------------------------------------------
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
