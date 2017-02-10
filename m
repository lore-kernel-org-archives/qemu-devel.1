Received: from eggs.gnu.org ([2001:4830:134:3::10]:36255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccDNA-0005WN-35
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccDN8-0006HL-Pn
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:44:32 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccDN8-0006H7-JW
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:44:30 -0500
Received: by mail-wr0-x234.google.com with SMTP id k90so110553193wrc.3
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 07:44:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170210150452.21550-1-alex.bennee@linaro.org>
References: <20170210150452.21550-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 15:44:08 +0000
Message-ID: <CAFEAcA8dvvz8cgx4ejXB0Ldibh7P4Q3rCmwdLP0Qr0E-23_EMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Travis updates
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

On 10 February 2017 at 15:04, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> The following changes since commit 7d2c6c95511e42dffe2b263275e09957723d0f=
f4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170206-1' =
into staging (2017-02-06 11:44:08 +0000)
>
> are available in the git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-travis-10022017-1
>
> for you to fetch changes up to 78a22af040b8ea7c26d52755facdc332ac7bac46:
>
>   .travis.yml: split VM based builds (2017-02-10 13:19:56 +0000)
>
> ----------------------------------------------------------------
> One minor fix and a build split to reduce timeouts.
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (2):
>       .travis.yml: don't specify CONFIG twice
>       .travis.yml: split VM based builds
>
>  .travis.yml | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)

Applied, thanks.

-- PMM
