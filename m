Received: from eggs.gnu.org ([2001:4830:134:3::10]:42760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpA6P-0003D0-Tp
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpA6L-0004MW-Cn
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:25:01 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dpA6L-0004M8-4H
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:24:57 -0400
Received: by mail-wm0-x22c.google.com with SMTP id h144so2386941wme.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:24:57 -0700 (PDT)
Date: Tue, 5 Sep 2017 10:24:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170905092453.GD17449@stefanha-x1.localdomain>
References: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
	<CAMzKsXuXQW9yQMX__3neQwZkwRaDRs6WgYW2DpyHVXRMVNu-aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzKsXuXQW9yQMX__3neQwZkwRaDRs6WgYW2DpyHVXRMVNu-aA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/14] add support for
 Hypervisor.framework in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio =?iso-8859-1?Q?Andr=E9s_G=F3mez?= del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Sep 04, 2017 at 10:59:43PM -0500, Sergio Andrés Gómez del Real wrote:
> This patchset didn't address every issue, so it won't be the definite
> version.

This series is fairly large and I don't want to review the same
unresolved issues multiple times.  I'll skip this revision and review
again once outstanding issues have been addressed.

Now would be a good time for someone familiar with VMX and x86 emulation
to review the meat of this.

Stefan
