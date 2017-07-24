Received: from eggs.gnu.org ([2001:4830:134:3::10]:55724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZfAK-00018x-9q
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZfAJ-0004h0-8t
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:21:00 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZfAJ-0004fm-1L
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:20:59 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 12so107831240wrb.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 08:20:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500898928-4901-1-git-send-email-armbru@redhat.com>
References: <1500898928-4901-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 16:20:37 +0100
Message-ID: <CAFEAcA86unkebCaPtOeWk95u+VFRPaZ1BUWrDVTi0uA2nf6Q=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Error reporting patches for 2017-07-24
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

On 24 July 2017 at 13:22, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit df95f1a298a3e16c80293343143dcedbe7978f6c:
>
>   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170721-tag' into staging (2017-07-24 10:01:15 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2017-07-24
>
> for you to fetch changes up to 70f17a15ca0fe47eeae1ac83086130e6e7ba57c8:
>
>   error: Revert unwanted change of warning messages (2017-07-24 14:16:29 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2017-07-24
>
> ----------------------------------------------------------------
> Markus Armbruster (1):
>       error: Revert unwanted change of warning messages
>
>  util/qemu-error.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Applied, thanks.

-- PMM
