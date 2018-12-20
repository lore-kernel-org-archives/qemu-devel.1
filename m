Received: from eggs.gnu.org ([2001:4830:134:3::10]:36377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ga55z-0000gm-NY
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ga55y-00044m-Ne
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:39:03 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:32822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ga55y-000446-GV
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:39:02 -0500
Received: by mail-ot1-x335.google.com with SMTP id i20so3190255otl.0
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 12:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20181220094514.3904-1-armbru@redhat.com>
In-Reply-To: <20181220094514.3904-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Dec 2018 20:38:49 +0000
Message-ID: <CAFEAcA9HgTJssfc1NHe+uNkAymzADuVbRh9Z=ymUW9Fa+Y4jRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Miscellaneous patches for 2018-12-20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 20 Dec 2018 at 09:47, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit b72566a4ffaddbc0c0c1f6f5ee91b42ab13ff429:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2018-12-19 15:31:02 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-12-20
>
> for you to fetch changes up to 3a6b016d6487f3492bc1b80b2c3bc25c67aab8e2:
>
>   build: Remake config-host.mak when VERSION changes (2018-12-20 10:31:08 +0100)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2018-12-20
>
> ----------------------------------------------------------------
> Markus Armbruster (2):
>       Clean up includes
>       build: Remake config-host.mak when VERSION changes

Applied, thanks.
-- PMM
