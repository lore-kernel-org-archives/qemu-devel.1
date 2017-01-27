Received: from eggs.gnu.org ([2001:4830:134:3::10]:51205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9nq-0004Ga-Dg
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9np-0007gX-Ch
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:55:10 -0500
Received: from mail-vk0-x22b.google.com ([2607:f8b0:400c:c05::22b]:33443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX9np-0007fx-5A
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:55:09 -0500
Received: by mail-vk0-x22b.google.com with SMTP id k127so178759264vke.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 08:55:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485502157-25445-1-git-send-email-armbru@redhat.com>
References: <1485502157-25445-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 16:54:48 +0000
Message-ID: <CAFEAcA_Ug9Y2yk1aiq7aJ=e=y_AMrfaPMpogkCAcAdJJXKKveA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] QAPI/QMP patches for 2017-01-27
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

On 27 January 2017 at 07:29, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b1f:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-01-25 17:54:14 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-01-27
>
> for you to fetch changes up to 7a8c153f0e59cccdc0425cdebe43765008def01a:
>
>   qmp: Fix argument name in error message of device-list-properties (2017-01-27 08:23:06 +0100)
>
> ----------------------------------------------------------------
> QAPI/QMP patches for 2017-01-27
>
> ----------------------------------------------------------------
> Lin Ma (1):
>       qmp: Fix argument name in error message of device-list-properties
>
> Markus Armbruster (1):
>       build-sys: Minor qapi doc generation target cleanups
>
> Stefan Weil (1):
>       qapi: Remove unwanted commas after #optional keyword

Applied, thanks.

-- PMM
