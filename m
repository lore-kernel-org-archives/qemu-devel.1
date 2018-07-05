Received: from eggs.gnu.org ([2001:4830:134:3::10]:48175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb7ze-0007oO-Hb
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb7zd-0000HJ-LA
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:24:34 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:40120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb7zd-0000H7-Fw
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:24:33 -0400
Received: by mail-oi0-x233.google.com with SMTP id w126-v6so18340039oie.7
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 10:24:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705131417.1847-1-armbru@redhat.com>
References: <20180705131417.1847-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 18:24:12 +0100
Message-ID: <CAFEAcA-0U5R4NfudXuD39Q+FHoeZ_v9aSOQAuc11tD7O90iqmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Coverity model patches for 2018-07-05
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

On 5 July 2018 at 14:14, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 4fd1cbaf146d4ab35f465bba0fe23115c33cd5a7:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2018-07-03-v2' into staging (2018-07-05 11:25:14 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-cov-model-2018-07-05
>
> for you to fetch changes up to 19020d41759c7d34eae78d6afbec27c523d55bcd:
>
>   coverity-model: Fix replay_get_byte() (2018-07-05 15:09:52 +0200)
>
> ----------------------------------------------------------------
> Coverity model patches for 2018-07-05
>
> ----------------------------------------------------------------
> Markus Armbruster (1):
>       coverity-model: Fix replay_get_byte()
>
>  scripts/coverity-model.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
Applied, thanks.

-- PMM
