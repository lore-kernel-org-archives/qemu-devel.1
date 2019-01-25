Received: from eggs.gnu.org ([209.51.188.92]:50654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmxyc-0004Vq-OS
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmxl1-0002EU-Rd
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:26:42 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:46910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmxkw-00029u-1b
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:26:35 -0500
Received: by mail-oi1-x22e.google.com with SMTP id x202so7173845oif.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 01:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20190124103651.26227-1-kraxel@redhat.com>
In-Reply-To: <20190124103651.26227-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 09:26:14 +0000
Message-ID: <CAFEAcA-xrGThJLJ-cd+00f=AnYszN9U+zVYUsCzx94MgSdrnhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Ui 20190124 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Thu, 24 Jan 2019 at 10:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f6b06fcceef465de0cf2514c9f76fe0192896781:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190121-pull-request' into staging (2019-01-23 17:57:47 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190124-pull-request
>
> for you to fetch changes up to 2657846fb2e47e8ba847b5ef6fe742466414c745:
>
>   input-linux: customizable grab toggle keys (2019-01-24 10:42:38 +0100)
>
> ----------------------------------------------------------------
> input-linux: customizable grab toggle keys
>
> ----------------------------------------------------------------
>
> Ryan El Kochta (1):
>   input-linux: customizable grab toggle keys
>
>  ui/input-linux.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  qapi/ui.json     | 10 +++++++++
>  2 files changed, 73 insertions(+), 3 deletions(-)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
