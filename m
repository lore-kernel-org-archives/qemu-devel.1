Received: from eggs.gnu.org ([2001:4830:134:3::10]:33952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv066-0002vi-KZ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv065-0007jj-QN
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:24:34 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv065-0007jO-Jd
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:24:33 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k6so159682230wre.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 04:24:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403100832.24088-1-david@gibson.dropbear.id.au>
References: <20170403100832.24088-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 12:24:11 +0100
Message-ID: <CAFEAcA_e91zx8Mwqfo=hCEnnRS_vb_AiQow_ZVNdx4SiGPZsxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] ppc-for-2.9 queue 20170403
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 3 April 2017 at 11:08, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 95b31d709ba343ad237c3630047ee7438bac4065:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20170331.0' into staging (2017-03-31 18:06:13 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170403
>
> for you to fetch changes up to 8149e2992f7811355cc34721b79d69d1a3a667dd:
>
>   pseries: Enforce homogeneous threads-per-core (2017-04-03 13:46:18 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-04-03
>
> A single bugfix in this pull request, for an ugly assert() failure, if
> the user ignores the information in query-hotpluggable-cpus and tries
> to hot add CPUs to pseries with bad parameters.
>
> ----------------------------------------------------------------
> David Gibson (1):
>       pseries: Enforce homogeneous threads-per-core

Applied, thanks.

-- PMM
