Received: from eggs.gnu.org ([2001:4830:134:3::10]:41346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erTEB-0007xh-0e
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erTEA-0004JU-5r
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:46:51 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:42647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erTE9-0004Ik-W3
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:46:50 -0500
Received: by mail-ot0-x230.google.com with SMTP id l5so6506590otf.9
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 10:46:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 18:46:28 +0000
Message-ID: <CAFEAcA8WdYgxEZ2LmDh=y3Q39k9waYYwx6DRRR41NeuTvXoKKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/27] s390x updates (and friends)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

On 1 March 2018 at 13:01, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:
>
>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180301-v2
>
> for you to fetch changes up to be8b49de2491145a7aad3201803327b6f568cbd3:
>
>   s390x/tcg: fix loading 31bit PSWs with the highest bit set (2018-03-01 13:23:09 +0100)
>
> ----------------------------------------------------------------
> - add query-cpus-fast and deprecate query-cpus, while adding s390 cpu
>   information
> - remove s390x memory hotplug implementation, which is not useable in
>   this form
> - add boot menu support in the s390-ccw bios
> - expose s390x guest crash information
> - fixes and cleaups
>

Applied, thanks.

-- PMM
