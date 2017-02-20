Received: from eggs.gnu.org ([2001:4830:134:3::10]:33488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfnt6-0003wd-Jx
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfnt5-0006nU-LT
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:20:20 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfnt5-0006nM-FK
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:20:19 -0500
Received: by mail-wr0-x235.google.com with SMTP id s27so17081441wrb.2
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 05:20:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487461713-23092-1-git-send-email-huth@tuxfamily.org>
References: <1487461713-23092-1-git-send-email-huth@tuxfamily.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 13:19:57 +0000
Message-ID: <CAFEAcA8v_AiTDrV+0juedq_v6q5cJOx4nUKc1Dmw6zaaVf7vuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] ColdFire patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 18 February 2017 at 23:48, Thomas Huth <huth@tuxfamily.org> wrote:
> The following changes since commit ad584d37f2a86b392c25f3f00cc1f1532676c2d1:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-02-16 17:46:52 +0000)
>
> are available in the git repository at:
>
>   https://github.com/huth/qemu.git tags/coldfire-20170219
>
> for you to fetch changes up to 5baf2741b4920c3227c14734986893c66b6b2eed:
>
>   MAINTAINERS: Add odd fixer for the ColdFire boards (2017-02-18 22:23:31 +0100)
>
> ----------------------------------------------------------------
> Updates for the m68k ColdFire machines:
> - Remove the obsolete dummy machine
> - QOMify the ColdFire interrupt controller
> - Volunteer for maintaining the orphan ColdFire boards
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
