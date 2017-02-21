Received: from eggs.gnu.org ([2001:4830:134:3::10]:56601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg4PQ-00071k-MQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 01:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg4PM-0003yJ-Pb
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 01:58:48 -0500
Received: from [59.151.112.132] (port=45264 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg4PM-0003y9-Da
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 01:58:44 -0500
References: <1487597638-28323-1-git-send-email-armbru@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <8ed45bc8-6051-ccae-6227-52d8553c04af@cn.fujitsu.com>
Date: Tue, 21 Feb 2017 14:57:48 +0800
MIME-Version: 1.0
In-Reply-To: <1487597638-28323-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/2] QAPI patches for 2017-02-20
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com

Hi~ Markus.

This patch set has been reviewed for a long time, can you pick up it?

[PATCH V7 0/2] Add new qmp commands to suppurt Xen COLO

Thanks

Zhang Chen


On 02/20/2017 09:33 PM, Markus Armbruster wrote:
> The following changes since commit d514cfd763b271b4e97a9fc6adaabc8fd50084ab:
>
>    Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-02-20 09:53:59 +0000)
>
> are available in the git repository at:
>
>    git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-02-20
>
> for you to fetch changes up to fea346f569d4132296f7c26367374fcace80e096:
>
>    Makefile: Put VERSION info into version.texi rather than using -D (2017-02-20 14:11:07 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-02-20
>
> ----------------------------------------------------------------
> Marc-André Lureau (1):
>        qapi2texi: replace quotation by bold section name
>
> Peter Maydell (1):
>        Makefile: Put VERSION info into version.texi rather than using -D
>
>   .gitignore             |  1 +
>   Makefile               | 17 ++++++++++-------
>   docs/qemu-ga-ref.texi  |  2 ++
>   docs/qemu-qmp-ref.texi |  2 ++
>   scripts/qapi2texi.py   | 10 ++++------
>   5 files changed, 19 insertions(+), 13 deletions(-)
>
> Marc-André Lureau (1):
>    qapi2texi: replace quotation by bold section name
>
> Peter Maydell (1):
>    Makefile: Put VERSION info into version.texi rather than using -D
>
>   .gitignore             |  1 +
>   Makefile               | 17 ++++++++++-------
>   docs/qemu-ga-ref.texi  |  2 ++
>   docs/qemu-qmp-ref.texi |  2 ++
>   scripts/qapi2texi.py   | 10 ++++------
>   5 files changed, 19 insertions(+), 13 deletions(-)
>

-- 
Thanks
Zhang Chen
