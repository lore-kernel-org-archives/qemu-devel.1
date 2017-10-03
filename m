Received: from eggs.gnu.org ([2001:4830:134:3::10]:46734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzP5q-0003Lx-BX
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzP5p-0007F9-Ad
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:26:46 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:52760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dzP5p-0007Eh-45
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 11:26:45 -0400
Received: by mail-wr0-x229.google.com with SMTP id k62so6611098wrc.9
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 08:26:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002111111.26932-1-armbru@redhat.com>
References: <20171002111111.26932-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Oct 2017 16:26:23 +0100
Message-ID: <CAFEAcA97f4bMDEb+h-v5KL4+7Q=tcH+NW6mMqCdGH_JsXJwjNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] QAPI patches for 2017-10-02
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

On 2 October 2017 at 12:11, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit ab161529261928ae7f3556e3220829c34b2686ec:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170927a' into staging (2017-09-27 22:44:51 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-10-02
>
> for you to fetch changes up to f0df84c6c46cb632dac2d9fae5fdbe6001527c3b:
>
>   watchdog: Allow setting action on the fly (2017-10-02 13:09:09 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-10-02
>
> ----------------------------------------------------------------
> Michal Privoznik (3):
>       qapi: Rename WatchdogExpirationAction enum
>       watchdog.h: Drop local redefinition of actions enum
>       watchdog: Allow setting action on the fly
>
Applied, thanks.

-- PMM
