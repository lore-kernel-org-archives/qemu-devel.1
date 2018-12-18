Received: from eggs.gnu.org ([2001:4830:134:3::10]:55695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZG3h-0001B3-7U
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZG3b-0002SU-DX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:09:17 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:44391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZG3Z-0002Qp-96
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:09:11 -0500
Received: by mail-oi1-x22e.google.com with SMTP id m6so1987846oig.11
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 06:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20181217105650.27361-1-alex.bennee@linaro.org>
In-Reply-To: <20181217105650.27361-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Dec 2018 14:08:55 +0000
Message-ID: <CAFEAcA_eBvVJvEDUwr4r2rbNiOp-10ysHNDS3RadOiU1tbqkpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/15] Hardfloat + softfloat maintainers
 update and gitdm
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

On Mon, 17 Dec 2018 at 10:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit b019f5e5375224a003f260c89d424fea7767b7=
fc:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-misc-20181214'=
 into staging (2018-12-16 16:32:43 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-hardfloat-and-gitdm-17121=
8-3
>
> for you to fetch changes up to d9fe9db943d4e855a75424978d7ab87fd54edd98:
>
>   hardfloat: implement float32/64 comparison (2018-12-17 08:25:25 +0000)
>
> ----------------------------------------------------------------
> Hardfloat + maintainers and gitdm
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
