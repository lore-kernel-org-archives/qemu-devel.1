Received: from eggs.gnu.org ([2001:4830:134:3::10]:51174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK68r-0000gB-Ej
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK64J-0005c2-5g
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:27:17 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:41766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK64B-000593-UB
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:27:09 -0500
Received: by mail-ot1-x32d.google.com with SMTP id c32so12343253otb.8
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 10:27:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181106173941.9449-1-armbru@redhat.com>
References: <20181106173941.9449-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 18:26:42 +0000
Message-ID: <CAFEAcA9BZvKTkwq2dgXJO_410ey_pvZDu7_wSvuUAdp76dhhig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/3] Monitor patches for 2018-10-30
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

On 6 November 2018 at 17:39, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 0ca70f19c010ccf0b10cf7cc1d2b9a87193fe787:
>
>   tests: Fix Python 3 detection on older GNU make versions (2018-11-06 14:58:13 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-10-30-v2
>
> for you to fetch changes up to 0c57893d62596d1d91779452be3b38b4b72ecd04:
>
>   vl: Avoid crash when -mon is underspecified (2018-11-06 17:03:29 +0100)
>
> ----------------------------------------------------------------
> Monitor patches for 2018-10-30
>
> * Fix crash on shutdown with --daemonize
> * Avoid crash when -mon lacks chardev=...
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
