Received: from eggs.gnu.org ([2001:4830:134:3::10]:48971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnkQb-0004mR-1j
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnkQa-0007fX-6O
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:15:44 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnkQa-0007ez-13
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:15:44 -0400
Received: by mail-wr0-x22e.google.com with SMTP id g10so121736530wrg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 04:15:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314042626.20020-1-david@gibson.dropbear.id.au>
References: <20170314042626.20020-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 12:15:22 +0100
Message-ID: <CAFEAcA_oS+b8dNbP62EUDTizP+NErtWEA+akKy3xjGbC2-b-=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] ppc-for-2.9 queue 20170314
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 14 March 2017 at 05:26, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 5bac3c39c82e149515c10643acafd1d292433775:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-03-13 15:08:01 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170314
>
> for you to fetch changes up to 28df75d8d1aebdb09a2cc511c0b97690eac0b7a7:
>
>   dtc: Update submodule to avoid build errors (2017-03-14 12:24:29 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2017-03-14
>
> This set has a handful og bugfixes to go into qemu-2.9.  This includes
> an update to the dtc/libfdt submodule which will fix the build errors
> seen on some distributions.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
