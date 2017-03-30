Received: from eggs.gnu.org ([2001:4830:134:3::10]:52211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctb3p-0003H5-R6
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctb3l-00077k-6p
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:28:25 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:34757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctb3k-00077D-VV
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:28:21 -0400
Received: by mail-lf0-x234.google.com with SMTP id z15so28162119lfd.1
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 07:28:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170329033415.891-1-david@gibson.dropbear.id.au>
References: <20170329033415.891-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 15:27:59 +0100
Message-ID: <CAFEAcA_Z9WWpL8DzN3X_OQaV6qjH0ZuOC67x4CM+MXzpOFBcHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-2.9 queue 20170329
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 29 March 2017 at 04:34, David Gibson <david@gibson.dropbear.id.au> wrote=
:
> The following changes since commit df9046363220e57d45818312759b954c033c58=
ab:
>
>   Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170329
>
> for you to fetch changes up to fe6824d12642b005c69123ecf8631f9b13553f8b:
>
>   spapr: fix memory hot-unplugging (2017-03-29 11:35:16 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2017-03-29
>
> Two more bugfixes of sufficient severity to warrant going into 2.9.
>
> ----------------------------------------------------------------
> Laurent Vivier (1):
>       spapr: fix memory hot-unplugging
>
> Marc-Andr=C3=A9 Lureau (1):
>       spapr: fix buffer-overflow
>
>  hw/ppc/spapr.c             |  4 ++--
>  hw/ppc/spapr_drc.c         | 20 +++++++++++++++++---
>  include/hw/ppc/spapr_drc.h |  1 +
>  3 files changed, 20 insertions(+), 5 deletions(-)


Applied, thanks.

-- PMM
