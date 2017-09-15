Received: from eggs.gnu.org ([2001:4830:134:3::10]:60162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dswIf-0005to-E5
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dswIe-0004tl-DB
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:29:17 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:49661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dswIe-0004tO-5t
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 15:29:16 -0400
Received: by mail-wr0-x229.google.com with SMTP id u96so2535654wrb.6
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 12:29:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2017 20:28:54 +0100
Message-ID: <CAFEAcA_dPzOCiO86-wh0aZf_=ScmudsTUbCsPaw27vzPhK1spw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] ppc-for-2.11 queue 20170915
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, gkurz@kaod.org, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 15 September 2017 at 04:51, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 3dabde1128b671f36ac6cb36b97b273139964420:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' into staging (2017-09-14 16:33:02 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20170915
>
> for you to fetch changes up to 70a0c19e83aa4c71c879d51e426e89e4b3d4e014:
>
>   ppc/kvm: use kvm_vm_check_extension() in kvmppc_is_pr() (2017-09-15 10:29:48 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-09-15
>
> Here's the current batch of accumulated ppc patches.  These are all
> pretty simple bugfixes or cleanups, no big new features here.
>

Applied, thanks.

-- PMM
