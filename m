Received: from eggs.gnu.org ([2001:4830:134:3::10]:39653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHt5x-0002ew-7R
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHt5w-0005gq-2s
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:11:49 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHt5v-0005f3-HH
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:11:47 -0400
Received: by mail-oi1-x242.google.com with SMTP id c25-v6so14106163oiy.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:11:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030173627.7711-1-marcandre.lureau@redhat.com>
References: <20181030173627.7711-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Oct 2018 16:11:25 +0000
Message-ID: <CAFEAcA9RhsPpOzwjdijZWJJk7tZ5RRqiU8DPiARKB+bF--uQzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] Chardev patches
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

On 30 October 2018 at 17:36, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit 3f3285491dd52014852a56135c90e428c8b507=
ea:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2018-10-30 14:09:25 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/chrdev-pull-request
>
> for you to fetch changes up to 22333dd533e2a93d9da18479aee5fb49302c7933:
>
>   editorconfig: set emacs mode (2018-10-30 21:30:22 +0400)
>
> ----------------------------------------------------------------
> - add websocket support
> - socket: make 'fd' incompatible with 'reconnect'
> - fix a websocket leak
> - unrelated editorconfig patch that missed -trivial (included for
>   convenience)
>
> ----------------------------------------------------------------
>
> Julia Suvorova (3):
>   chardev/char-socket: Function headers refactoring
>   chardev: Add websocket support
>   tests/test-char: Check websocket chardev functionality

Hi -- it looks like this pull request includes some
commits where the author field is "somebody  via
Qemu-devel <qemu-devel@nongnu.org>" (this is an artefact
of the mailing list's handling of senders with SPF setups).
Could you fix up those commits to have the right email
address for their authors, please?

thanks
-- PMM
