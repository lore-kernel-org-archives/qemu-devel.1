Received: from eggs.gnu.org ([209.51.188.92]:44434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqgh6-0000hr-5D
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqgh2-0004b2-DG
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:01:58 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqgh0-0004Ck-CF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:01:56 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so512704ota.12
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 08:01:38 -0800 (PST)
MIME-Version: 1.0
References: <1549268743-18502-1-git-send-email-thuth@redhat.com>
	<87o97r4s8l.fsf@zen.linaroharston>
In-Reply-To: <87o97r4s8l.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 16:01:26 +0000
Message-ID: <CAFEAcA9kiRkx0-MRTrvUcDQ+wGZ9KGS44-2+0tSsjgbJY83ieg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/docker/test-mingw and docs: Remove
 --with-sdlabi=2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Mon, 4 Feb 2019 at 13:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > Patchew currently reports failures with the mingw docker test - this
> > is due to --with-sdlabi=3D2.0 configure flag which does not exist anymo=
re.
> > Remove this remainder from the docker test and the docs now.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> I'm happy for this to be applied directly by Peter.

Applied to master as a buildfix, thanks.

-- PMM
