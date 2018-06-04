Received: from eggs.gnu.org ([2001:4830:134:3::10]:36719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPla9-0007xw-Fd
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPla8-000391-7v
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:15:17 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:35101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPla8-00038B-2Y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:15:16 -0400
Received: by mail-ot0-x22f.google.com with SMTP id q17-v6so26148486otg.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:15:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601162101.895-1-alex.bennee@linaro.org>
References: <20180601162101.895-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 10:14:55 +0100
Message-ID: <CAFEAcA-kg5JdCFsJvx5DBS408xF-cE8-thbchQvf1=mEyp7toA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] Travis updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 1 June 2018 at 17:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit c25e8bba1f546ea72744ccfab77f8a9e8a323b=
e8:
>
>   Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20180601'=
 into staging (2018-06-01 13:11:30 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-travis-updates-010618-1
>
> for you to fetch changes up to ac07ffc65472ec3b1255f427051481fc9050a2f8:
>
>   .travis.yml: update GCC sanitizer build to GCC 7 (2018-06-01 15:00:54 +=
0100)
>
> ----------------------------------------------------------------
> Some Travis & Docker updates
>
>  - simplification of the build matrix
>  - usability tweaks for docker
>  - update Travis docker image
>

Applied, thanks.

-- PMM
