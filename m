Received: from eggs.gnu.org ([2001:4830:134:3::10]:50675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9SVR-0000dh-KR
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9SVM-0007YK-BZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:11:15 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9SVJ-0007UY-6C
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:11:10 -0400
Received: by mail-oi1-x230.google.com with SMTP id u74-v6so15292453oia.11
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 03:11:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005122910.11745-1-marcandre.lureau@redhat.com>
References: <20181005122910.11745-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 11:10:43 +0100
Message-ID: <CAFEAcA85S9fifsVteshNtOwvR2XbwLR0pGa-c2hVWe8JM+zYWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/12] Option patches
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

On 5 October 2018 at 13:28, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> The following changes since commit b8e5671a8cd196e7262802ca895bf87d504169=
89:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/chardev-pull-request=
' into staging (2018-10-03 14:07:49 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/option-pull-request
>
> for you to fetch changes up to 1195fa2b08d98ab503155c5cee8831d1ef91aac5:
>
>   vl: list user creatable properties when 'help' is argument (2018-10-05 =
16:27:09 +0400)
>
> ----------------------------------------------------------------
> CLI help improvements
>
> PULLv2:
>  - fix uninitialized "seentype" variable in qom-test
>

Applied, thanks.

-- PMM
