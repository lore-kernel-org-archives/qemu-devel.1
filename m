Received: from eggs.gnu.org ([2001:4830:134:3::10]:39755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkYdA-0000ra-3F
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkYd8-0000Xh-Sj
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:40:20 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkYd8-0000X6-MW
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 13:40:18 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so29485861oie.13
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 10:40:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180731155156.25994-1-armbru@redhat.com>
References: <20180731155156.25994-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jul 2018 18:39:57 +0100
Message-ID: <CAFEAcA9FOSHDQ_v4SdzOgJ1JPvDtbnOKckx5hSc5+cQyAsLBnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Monitor patches for 2018-07-31
 (3.0.0-rc3)
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

On 31 July 2018 at 16:51, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 42e76456cf68dc828b8dbd3c7e255197e9b5e5=
7d:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-p=
ull-request' into staging (2018-07-31 13:52:03 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-07-31
>
> for you to fetch changes up to 9a1054061c62311f6efcd88e4df0aa5203c7b39a:
>
>   monitor: temporary fix for dead-lock on event recursion (2018-07-31 17:=
42:57 +0200)
>
> ----------------------------------------------------------------
> Monitor patches for 2018-07-31 (3.0.0-rc3)
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       monitor: temporary fix for dead-lock on event recursion
>
>  monitor.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
