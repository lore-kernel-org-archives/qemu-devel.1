Received: from eggs.gnu.org ([2001:4830:134:3::10]:36928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZfkc-00084i-7K
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZfkb-0006Lp-Ek
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:58:30 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZfkb-0006LP-6g
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:58:29 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m85so21362947wma.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 08:58:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724140149.1933-1-eblake@redhat.com>
References: <20170724140149.1933-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 16:58:05 +0100
Message-ID: <CAFEAcA8+g_GuKWt=qQBOYBpJAev49SZL7MLWbxtYvOducLbngw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 0/2] NBD patches for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 July 2017 at 15:01, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit cf44d31d35df3de9d4f49339254050195f777f3e:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-18-v2' into staging (2017-07-24 13:21:33 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-07-24
>
> for you to fetch changes up to c2a3d7dad2e153668b5a004e4f8336da92c476e1:
>
>   maint: Reorder include directives for qemu-{nbd, io} (2017-07-24 08:53:08 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2017-07-24
>
> - Eric Blake: [0/2] Update qemu-nbd version
>
> ----------------------------------------------------------------
> Eric Blake (2):
>       qemu-nbd: Update version string
>       maint: Reorder include directives for qemu-{nbd, io}
>
>  qemu-img.c |  3 ++-
>  qemu-nbd.c | 13 +++++++------
>  2 files changed, 9 insertions(+), 7 deletions(-)

Applied, thanks.

-- PMM
