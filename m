Received: from eggs.gnu.org ([2001:4830:134:3::10]:40538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjkNp-0000QQ-DZ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjkNo-0003YB-Bl
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:24:21 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:32881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjkNo-0003Xo-4E
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:24:20 -0500
Received: by mail-wr0-x22b.google.com with SMTP id u48so70599951wrc.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 02:24:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303032507.16142-1-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 10:23:58 +0000
Message-ID: <CAFEAcA_vdv6xY0Q3c4sX2VR8t3kCa2eWbycMs7GqyCQBLbk1cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/17] ppc-for-2.9 queue 20170303
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, sjitindarsingh@gmail.com, Sam Bobroff <sam.bobroff@au1.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 3 March 2017 at 03:24, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit ecb24d334af1a98ef0329f4b3b0e14ae8cb8770d:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tgt-20170302' into staging (2017-03-02 22:06:41 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170303
>
> for you to fetch changes up to 992d7e976c7eca2b3129cd4bae4a0d350a8065fa:
>
>   target/ppc: rewrite f[n]m[add,sub] using float64_muladd (2017-03-03 11:38:33 +1100)
>
> ----------------------------------------------------------------
> ppc patch queuye for 2017-03-03
>
> This will probably be my last pull request before the hard freeze.  It
> has some new work, but that has all been posted in draft before the
> soft freeze, so I think it's reasonable to include in qemu-2.9.

The rule is: pull requests on the list by the softfreeze
date, no new features after that... "OK if a patch hit the list before
softfreeze" was the old rule which we had for 2.7 and earlier.

thanks
-- PMM
