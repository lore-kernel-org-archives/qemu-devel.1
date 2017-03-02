Received: from eggs.gnu.org ([2001:4830:134:3::10]:55392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjZwC-00046P-CD
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjZwB-0002Bg-Eb
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:15:08 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjZwB-0002A8-7y
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:15:07 -0500
Received: by mail-wm0-x233.google.com with SMTP id n11so3349893wma.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 15:15:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301195502.4432-1-rth@twiddle.net>
References: <20170301195502.4432-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 23:14:45 +0000
Message-ID: <CAFEAcA9NOndeod2ogU4XuHfymcLFx6-eeO7KpJSC74kq6CAQJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL] target/sparc queued patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 March 2017 at 19:55, Richard Henderson <rth@twiddle.net> wrote:
> This one has been languishing for a few weeks.
>
>
> r~
>
>
>
> The following changes since commit b28f9db1a7ce4d537ce2fae6fbce5e5e37dc265b:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170228-1' into staging (2017-03-01 17:58:54 +0000)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tgt-20170302
>
> for you to fetch changes up to 3db010c3398d03646d74f2d36a68e62539342e6c:
>
>   target/sparc: Restore ldstub of odd asis (2017-03-02 06:52:43 +1100)
>
> ----------------------------------------------------------------
> Queued sparc patch
>
> ----------------------------------------------------------------
> Richard Henderson (1):
>       target/sparc: Restore ldstub of odd asis
>
>  target/sparc/translate.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)



Applied, thanks.

-- PMM
