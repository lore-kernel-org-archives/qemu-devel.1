Received: from eggs.gnu.org ([2001:4830:134:3::10]:52833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIXcG-0003Xm-R1
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIXcF-0000sa-Vp
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:27:52 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIXcF-0000sI-KV
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:27:51 -0400
Received: by mail-ot1-x341.google.com with SMTP id q5so1346388otl.13
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 04:27:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181101082423.26424-1-marcandre.lureau@redhat.com>
References: <20181101082423.26424-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 11:27:30 +0000
Message-ID: <CAFEAcA_s9WC5F6+2K1C7Z8f-QUp391btgmMJk2ai0cTYbbaqHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 0/7] Chardev patches
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

On 1 November 2018 at 08:24, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9=
cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1=
-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/chrdev-pull-request
>
> for you to fetch changes up to 1ad723e98b8499d0690f7f7eafc945908a1db634:
>
>   editorconfig: set emacs mode (2018-11-01 12:13:12 +0400)
>
> ----------------------------------------------------------------
> - add websocket support
> - socket: make 'fd' incompatible with 'reconnect'
> - fix a websocket leak
> - unrelated editorconfig patch that missed -trivial (included for
>   convenience)
> - v2: fix commit author field
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
