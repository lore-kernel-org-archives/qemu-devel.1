Received: from eggs.gnu.org ([2001:4830:134:3::10]:55699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGNwU-0007dV-2o
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGNwT-0002lq-7e
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:07:02 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGNwS-0002kT-VY
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:07:01 -0400
Received: by mail-wm0-x22d.google.com with SMTP id d127so55483432wmf.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 04:07:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170530191121.1920-1-ehabkost@redhat.com>
References: <20170530191121.1920-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 12:06:39 +0100
Message-ID: <CAFEAcA88=yXR7KbDJL6do9C9vLZEwMGHZZ2-bWCoKfiy-dtMfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] NUMA fixes, 2017-05-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 30 May 2017 at 20:11, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 0748b3526e8cb78b9cd64208426bfc3d54a72b=
04:
>
>   Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (20=
17-05-30 14:15:15 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/numa-pull-request
>
> for you to fetch changes up to f892291eee376505cfec8b6cade7ccf952a6d3e0:
>
>   numa: Fix format string for "Invalid node" message (2017-05-30 16:09:58=
 -0300)
>
> ----------------------------------------------------------------
> NUMA fixes, 2017-05-30
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (1):
>   numa: Fix format string for "Invalid node" message
>
> Marc-Andr=C3=A9 Lureau (1):
>   numa-test: fix query-cpus leaks
>
>  numa.c            |  3 +--
>  tests/numa-test.c | 14 +++++++++-----
>  2 files changed, 10 insertions(+), 7 deletions(-)

Applied, thanks.

-- PMM
