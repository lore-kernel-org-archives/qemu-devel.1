Received: from eggs.gnu.org ([209.51.188.92]:37774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJGoP-00045x-8q
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJGoN-0007IK-6w
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:41 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:34628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hJGoN-0007H5-0t
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:15:39 -0400
Received: by mail-oi1-x229.google.com with SMTP id v10so14074961oib.1
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190418205135.6686-1-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Apr 2019 13:15:26 +0100
Message-ID: <CAFEAcA8SPuiUHEcXHBfTigo79TRp6Qr6QHnXN3SY2odUr=0HvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-4.1 00/36] Error reporting & monitor
 patches for 2019-04-18
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

On Thu, 18 Apr 2019 at 21:53, Markus Armbruster <armbru@redhat.com> wrote:
>
> Early pull request because I'll be on vacation when 4.1 opens.  Hope
> that's okay.
>
> The following changes since commit eeba63fc7fface36f438bcbc0d3b02e7dcb59983:
>
>   Update version for v4.0.0-rc4 release (2019-04-16 21:53:00 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-monitor-2019-04-18
>
> for you to fetch changes up to ede9a8a656c992deecce45f8175985dd81cc6be9:
>
>   include: Move fprintf_function to disas/ (2019-04-18 22:18:59 +0200)
>
> ----------------------------------------------------------------
> Error reporting & monitor patches for 2019-04-18
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
