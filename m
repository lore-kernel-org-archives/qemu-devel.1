Received: from eggs.gnu.org ([2001:4830:134:3::10]:48911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAZUN-0003A5-6c
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAZUM-0002rl-Dc
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:46:15 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:54474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAZUM-0002qX-7U
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:46:14 -0400
Received: by mail-wr0-x22a.google.com with SMTP id o44so2100258wrf.11
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 03:46:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171102144034.888-1-alex.bennee@linaro.org>
References: <20171102144034.888-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 10:45:52 +0000
Message-ID: <CAFEAcA9EZKf4iPZ-NCJmGOkad1R2r46FP9dncHDaPeGm1aXjEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] cross-compiler build fixes for
 softfreeze
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

On 2 November 2017 at 14:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> The following changes since commit d2b9d71432687eef947f243a57409381151701=
d5:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171030' =
into staging (2017-10-31 11:18:00 +0000)
>
> are available in the git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-ci-updates-for-softfreeze=
-021117-2
>
> for you to fetch changes up to e58c1f9b35e81dec90c3d483b57351256cecfc41:
>
>   docker: add python stdlib dependency (required by keycodemapdb) (2017-1=
1-02 11:46:41 +0000)
>
> ----------------------------------------------------------------
> One fix for win32/64 cross compiles.
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (1):
>       docker: add python stdlib dependency (required by keycodemapdb)
>
>  tests/docker/dockerfiles/debian8-mxe.docker | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- PMM
