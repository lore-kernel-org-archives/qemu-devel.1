Received: from eggs.gnu.org ([2001:4830:134:3::10]:60654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUZnv-00060I-PR
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUZnu-0007cO-Pm
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:04:35 -0500
Received: from mail-vk0-x22b.google.com ([2607:f8b0:400c:c05::22b]:34601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUZnu-0007c1-DE
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:04:34 -0500
Received: by mail-vk0-x22b.google.com with SMTP id r136so51992885vke.1
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:04:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484837637-16896-1-git-send-email-armbru@redhat.com>
References: <1484837637-16896-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 14:04:13 +0000
Message-ID: <CAFEAcA8D5GD3inrv55P60k=+ny-Ya_s7y8Pb4ZOW8bTzmHtY9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Error reporting patches for 2017-01-19
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

On 19 January 2017 at 14:53, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit ab4b92760498e097ff668f0e9c83aa87a2ec11=
28:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2017-01-17 16:54:09 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2017-01-19
>
> for you to fetch changes up to 0d6b50d474090b9085c595e2475c40cfdc092411:
>
>   error: Report certain hints on stderr when no monitor (2017-01-19 15:42=
:36 +0100)
>
> ----------------------------------------------------------------
> Error reporting patches for 2017-01-19
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       error: Report certain hints on stderr when no monitor
>
> Sascha Silbe (1):
>       error: error_setg_errno(): errno gets preserved
>
>  include/qapi/error.h | 3 +++
>  monitor.c            | 2 ++
>  2 files changed, 5 insertions(+)

Applied, thanks.

-- PMM
