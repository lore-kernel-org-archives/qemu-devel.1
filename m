Received: from eggs.gnu.org ([209.51.188.92]:37703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjPYX-0003Ex-3F
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjPYV-00047q-4O
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:05 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:35497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gjPYU-00046x-T4
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:19:03 -0500
Received: by mail-oi1-x234.google.com with SMTP id v6so2237471oif.2
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 06:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20190114160956.7513-1-alex.bennee@linaro.org>
In-Reply-To: <20190114160956.7513-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Jan 2019 14:18:50 +0000
Message-ID: <CAFEAcA_6cE2XKMaaO4RaYtGwEP-HPHSA06y946n1FXDoB695-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/5] gitdm updates with final 2018 stats
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

On Mon, 14 Jan 2019 at 16:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b=
16:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-=
part2' into staging (2019-01-14 11:41:43 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-misc-gitdm-next-140119-1
>
> for you to fetch changes up to 92329a7e70bc9755fd7114b8f91f95ed0b97648f:
>
>   MAINTAINERS: add myself as a route for gitdm updates (2019-01-14 16:06:=
57 +0000)
>
> ----------------------------------------------------------------
> gitdm updates with 2018 year end stats:
>
>   git log --numstat --after=3D"1/1/2018 00:00" --before=3D"31/12/2018 23:=
59" | ~/src/gitdm.git/gitdm -n -l 10
>
>   Top changeset contributors by employer
>   Red Hat                   3091 (43.3%)
>   Linaro                    1201 (16.8%)
>   (None)                     484 (6.8%)
>   IBM                        426 (6.0%)
>   Academics (various)        186 (2.6%)
>   Virtuozzo                  172 (2.4%)
>   Wave Computing             118 (1.7%)
>   Igalia                     109 (1.5%)
>   Xilinx                     102 (1.4%)
>   Cadence Design Systems      80 (1.1%)
>
>   Top lines changed by employer
>   Red Hat                   140523 (30.3%)
>   Cadence Design Systems    81010 (17.5%)
>   Linaro                    78098 (16.8%)
>   Wave Computing            33134 (7.1%)
>   IBM                       18918 (4.1%)
>   SiFive                    14436 (3.1%)
>   Academics (various)       11995 (2.6%)
>   (None)                    11458 (2.5%)
>   Virtuozzo                 10770 (2.3%)
>   Oracle                    6698 (1.4%)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
