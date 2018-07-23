Received: from eggs.gnu.org ([2001:4830:134:3::10]:44271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhfVG-0004tt-NK
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhfVF-0006rz-Od
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:24:14 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhfVF-0006rp-I9
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:24:13 -0400
Received: by mail-oi0-x241.google.com with SMTP id b15-v6so2851623oib.10
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 11:24:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180723164530.26599-1-kwolf@redhat.com>
References: <20180723164530.26599-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 19:23:52 +0100
Message-ID: <CAFEAcA9xC+aPXB++j6D8sVjrDohSqTmwsmNXV+iGots_PHtmNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 23 July 2018 at 17:45, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 55b1f14cefcb19ce6d5e28c4c83404230888aa7e:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (2018-07-23 14:03:14 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 3e31b4e17064d22e533071aaa57d3f01499ef910:
>
>   block/vvfat: Disable debug message by default (2018-07-23 16:50:43 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - vvfat: Disable debug message by default
> - qemu-iotests fixes
> - Fix typos in comments
>

Applied, thanks.

-- PMM
