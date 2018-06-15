Received: from eggs.gnu.org ([2001:4830:134:3::10]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTor2-0004s5-So
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTor1-00088U-UB
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:33:28 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:37933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTor1-00087s-PM
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:33:27 -0400
Received: by mail-ot0-x22e.google.com with SMTP id p95-v6so10993854ota.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 06:33:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180615110903.29674-1-alex.bennee@linaro.org>
References: <20180615110903.29674-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 14:33:06 +0100
Message-ID: <CAFEAcA-kwcT2ud=w1o+KO95Mz_AMkzvicbua+FDdUmraE3Vu4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Travis updates
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

On 15 June 2018 at 12:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 409c241f887a38bb7a2ac12e34d3a8d73922a9=
a5:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180614-pull-requ=
est' into staging (2018-06-14 14:04:14 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-travis-updates-140618-1
>
> for you to fetch changes up to f8309de9b7e7de1bfdfaddf8df4130a06e7e31b7:
>
>   travis: reduce time taken for trace-backend testing (2018-06-14 20:24:0=
7 +0100)
>
> ----------------------------------------------------------------
> Travis updates
>
>   - show config.log when failing
>   - reduce time for gprof build
>   - reduce time for alternate trace builds

Applied, thanks.

-- PMM
