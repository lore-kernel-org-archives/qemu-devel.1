Received: from eggs.gnu.org ([209.51.188.92]:44877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyK29-0005I0-S5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyK29-0001wE-4O
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:27:17 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:42096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyK28-0001vM-MS
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:27:17 -0500
Received: by mail-ot1-x32d.google.com with SMTP id i5so8506655oto.9
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 09:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20190222095421.28938-1-alex.bennee@linaro.org>
In-Reply-To: <20190222095421.28938-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 17:27:04 +0000
Message-ID: <CAFEAcA_u3+aNiiowKkjxcx-nhLJozrLj3c6KX5SpTV9EPapEtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/9] various Travis and Docker fixes,
 add gitlab CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 22 Feb 2019 at 09:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4=
a9:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-02-21 13:09:33 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-next-220219-1
>
> for you to fetch changes up to 4300dadc00bec6d75283ffbe1fd85c2b442bef2d:
>
>   tests/cdrom-test: only include isapc cdrom test when g_test_slow() (201=
9-02-22 09:32:32 +0000)
>
> ----------------------------------------------------------------
> Various testing fixes:
>
>   - Travis updates (inc disable isapc cdrom test)
>   - Add gitlab control
>   - Fix docker image
>   - keep softloat tests short


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
