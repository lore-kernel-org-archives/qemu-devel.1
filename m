Received: from eggs.gnu.org ([2001:4830:134:3::10]:58433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjogS-00087e-R2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjogS-0007au-0A
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:59:52 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjogR-0007am-QI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 09:59:51 -0500
Received: by mail-wm0-x22f.google.com with SMTP id t193so17395071wmt.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 06:59:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303063009.21580-1-david@gibson.dropbear.id.au>
References: <20170303063009.21580-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 14:59:30 +0000
Message-ID: <CAFEAcA_Lf_YPsm+BZby4jSoBed=eALN7z2Qi-irTtSYih+_QUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] submodule-update queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>

On 3 March 2017 at 06:30, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit ecb24d334af1a98ef0329f4b3b0e14ae8cb8770d:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tgt-20170302' into staging (2017-03-02 22:06:41 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/submodule-update-20170303
>
> for you to fetch changes up to 125a9cb8e386980d04a1ac8e04fe9e5c0e826c6f:
>
>   Update dtc submodule to v1.4.3 (2017-03-03 17:25:32 +1100)
>
> ----------------------------------------------------------------
> submodule updates (SLOF & dtc) 2017-03-03
>
> This set of patches updates the SLOF and dtc submodules for qemu-2.9.
>
> The SLOF update could have gone in my ppc pull request earlier today,
> but I forgot it.  It should be safe to apply in either order with that
> set though.
>
> The dtc (and libfdt) update brings us up to dtc 1.4.3 which includes
> some things that will be useful in future.

Applied, thanks.

-- PMM
