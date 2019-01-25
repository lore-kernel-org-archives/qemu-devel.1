Received: from eggs.gnu.org ([209.51.188.92]:40211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn0zg-0007PK-A0
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gn0wX-0000fS-2u
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:50:48 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:46941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gn0wS-0000bP-UO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:50:42 -0500
Received: by mail-oi1-x232.google.com with SMTP id x202so7542140oif.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 04:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20190124143825.25921-1-armbru@redhat.com>
In-Reply-To: <20190124143825.25921-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 12:30:18 +0000
Message-ID: <CAFEAcA_U+781Tt_GgnP0fT8q8wH2=OaGJx6GKcpbjqbprm3m1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] QAPI patches for 2019-01-24
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

On Thu, 24 Jan 2019 at 14:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit f6b06fcceef465de0cf2514c9f76fe0192896781:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190121-pull-request' into staging (2019-01-23 17:57:47 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-01-24
>
> for you to fetch changes up to bbc0586ced6e9ffdfd29d89fcc917b3d90ac3938:
>
>   json: Fix % handling when not interpolating (2019-01-24 15:20:59 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-01-24
>
> ----------------------------------------------------------------
> Christophe Fergeau (1):
>       json: Fix % handling when not interpolating
>
> Markus Armbruster (2):
>       qapi: Belatedly update docs for commit 9c2f56e9f9d
>       qapi: Eliminate indirection through qmp_event_get_func_emit()
>
> Wainer dos Santos Moschetta (1):
>       qmp: Add examples to qom list, get, and set commands

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
